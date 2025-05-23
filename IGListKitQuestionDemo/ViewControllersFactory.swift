//
//  ViewControllersFactory.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/11/25.
//

import UIKit

final class ViewControllersFactory {

    static func createMCQViewController() -> UIViewController {
        let questionService = SingleChoiceQuestionServiceAsyncDecorator(decoratee: SingleChoiceQuestionServiceImpl())
        let answerService = SingleChoiceAnswerServiceAsyncDecorator(decoratee: SingleChoiceAnswerServiceImpl())
        let refreshController = RefreshQuestionController(service: questionService)
        let pageViewModel = MCQViewModel()
        let viewController = MCQViewController(refreshController: refreshController, pageViewModel: pageViewModel)
        refreshController.onRefresh = { [weak pageViewModel] question in
            pageViewModel?.questionWithOptionsViewModel = QuestionWithOptionsViewModelMapper.map(question, selection: { option in
                print("option.id = \(option.id) is selected")
                let answer = SingleChoiceAnswer(questionId: question.id, selectedOptionId: option.id)
                answerService.submitSingleChoiceAnswer(answer) {
                    print("answer \(answer.id) for question id \(answer.questionId) with selected option id \(answer.selectedOptionId) is submitted!")
                }
            }, verification: { question in
                print("verify question: \(question)")
                return false
            })
        }
        return viewController
    }

    static func createSAViewController() -> UIViewController {
        let question = ShortTextQuestion(title: "Tell your story", placeholder: "Enter text here", id: Int.random(in: 0...Int.max))
        let pageViewModel = SAViewModel(textViewViewModel: TextViewViewModel(shortTextQuestion: question)) { text in
            guard let text else { return false }
            return !text.isEmpty
        }
        let viewController = SAViewController(pageViewModel: pageViewModel)
        return viewController
    }

    static func createContactInfoViewController() -> UIViewController {
        let questionsProvider = ContactInfoFormProviderImpl()
        var contactInfoViewModels: [TextFieldViewModel] = []
        questionsProvider.getContactInfoForm { contactInfoForm in
            contactInfoViewModels = [
                contactInfoForm.firstName,
                contactInfoForm.lastName,
                contactInfoForm.city,
                contactInfoForm.email,
                contactInfoForm.phone,
                contactInfoForm.address,
                contactInfoForm.zipCode,
                contactInfoForm.state,
                contactInfoForm.country
            ].compactMap { question in
                guard let question = question else { return nil }
                return TextFieldViewModel(title: question.title, placeholder: question.placeholder)
            }
        }
        let vm = ContactInfoViewModel(contactInfoViewModels: contactInfoViewModels)
        let viewController = ContactInfoViewController(pageViewModel: vm)
        return viewController
    }

    static func createTabBar(viewController1: UIViewController, viewController2: UIViewController, viewController3: UIViewController) -> UITabBarController {

        let one: () -> UIViewController = {
            let view = UINavigationController(
                rootViewController: viewController1)
            view.tabBarItem.title = viewController1.title
            return view
        }

        let two: () -> UIViewController = {
            let view = UINavigationController(
                rootViewController: viewController2)
            view.tabBarItem.title = viewController2.title
            return view
        }

        let three: () -> UIViewController = {
            let view = UINavigationController(
                rootViewController: viewController3)
            view.tabBarItem.title = viewController3.title
            return view
        }

        let tabBar = UITabBarController()
        tabBar.viewControllers = [one(), two(), three()]
        return tabBar
    }
}
