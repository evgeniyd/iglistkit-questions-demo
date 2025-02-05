//
//  ViewControllersFactory.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/11/25.
//

import UIKit

final class ViewControllersFactory {

    static func createTwoSectionControllersExampleViewController() -> UIViewController {
        let questionService = SingleChoiceQuestionServiceAsyncDecorator(decoratee: SingleChoiceQuestionServiceImpl())
        let answerService = SingleChoiceAnswerServiceAsyncDecorator(decoratee: SingleChoiceAnswerServiceImpl())
        let refreshController = RefreshQuestionController(service: questionService)
        let viewController = TwoSectionControllersExampleViewController(refreshController: refreshController)
        refreshController.onRefresh = { [weak viewController] question in
            viewController?.pageViewModel = PageViewModelMapper.map(question, selection: { option in
                print("option.id = \(option.id) is selected")
                let answer = SingleChoiceAnswer(questionId: question.id, selectedOptionId: option.id)
                answerService.submitSingleChoiceAnswer(answer) {
                    print("answer \(answer.id) for question id \(answer.questionId) with selected option id \(answer.selectedOptionId) is submitted!")
                }
            })
        }
        return viewController
    }

    static func createOneSectionControllerExampleViewController() -> UIViewController {
        let questionService = SingleChoiceQuestionServiceAsyncDecorator(decoratee: SingleChoiceQuestionServiceImpl())
        let answerService = SingleChoiceAnswerServiceAsyncDecorator(decoratee: SingleChoiceAnswerServiceImpl())
        let refreshController = RefreshQuestionController(service: questionService)
        let viewController = OneSectionControllerExampleViewController(refreshController: refreshController)
        refreshController.onRefresh = { [weak viewController] question in
            viewController?.pageViewModel = PageViewModelMapper.map(question, selection: { option in
                print("option.id = \(option.id) is selected")
                let answer = SingleChoiceAnswer(questionId: question.id, selectedOptionId: option.id)
                answerService.submitSingleChoiceAnswer(answer) {
                    print("answer \(answer.id) for question id \(answer.questionId) with selected option id \(answer.selectedOptionId) is submitted!")
                }
            })
        }
        return viewController
    }

    static func createTabBar(viewController1: UIViewController, viewController2: UIViewController) -> UITabBarController {

        let two: () -> UIViewController = {
            let view = UINavigationController(
                rootViewController: viewController2)
            view.tabBarItem.title = viewController2.title
            return view
        }

        let one: () -> UIViewController = {
            let view = UINavigationController(
                rootViewController: viewController1)
            view.tabBarItem.title = viewController1.title
            return view
        }

        let tabBar = UITabBarController()
        tabBar.viewControllers = [one(), two()]
        return tabBar
    }
}
