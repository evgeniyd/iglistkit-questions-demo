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
        let refreshController = RefreshQuestionController(service: questionService)
        let viewController = TwoSectionControllersExampleViewController(refreshController: refreshController)
        refreshController.onRefresh = { [weak viewController] question in
            viewController?.pageViewModel = PageViewModelMapper.map(question, selection: { option in
                print("option.id = \(option.id) is selected")
            })
        }
        return viewController
    }

    static func createOneSectionControllerExampleViewController() -> UIViewController {
        let questionService = SingleChoiceQuestionServiceAsyncDecorator(decoratee: SingleChoiceQuestionServiceImpl())
        let refreshController = RefreshQuestionController(service: questionService)
        let viewController = OneSectionControllerExampleViewController(refreshController: refreshController)
        refreshController.onRefresh = { [weak viewController] question in
            viewController?.pageViewModel = PageViewModelMapper.map(question, selection: { option in
                print("option.id = \(option.id) is selected")
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
