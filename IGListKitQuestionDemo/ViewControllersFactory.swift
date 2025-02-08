//
//  ViewControllersFactory.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/11/25.
//

import UIKit

final class ViewControllersFactory {

    static func createManySectionControllerExampleViewController() -> UIViewController {
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

    static func createTextFieldSectionControllersExampleViewController() -> UIViewController {
        let pageViewModel = TextFieldViewModel(title: "First Name", placeholder: "Enter text here")
        let viewController = SAViewController(textFieldViewModel: pageViewModel)
        return viewController
    }

    static func createTabBar(viewController1: UIViewController, viewController2: UIViewController) -> UITabBarController {

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

        let tabBar = UITabBarController()
        tabBar.viewControllers = [one(), two()]
        return tabBar
    }
}
