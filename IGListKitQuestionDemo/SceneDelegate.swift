//
//  SceneDelegate.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/10/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Ensure the scene is a UIWindowScene
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        let questionService = SingleChoiceQuestionServiceAsyncDecorator(decoratee: SingleChoiceQuestionServiceImpl())
        let refreshController = RefreshQuestionController(service: questionService)
        let rootViewController = TwoSectionControllersExampleViewController(refreshController: refreshController)
        refreshController.onRefresh = { [weak rootViewController] question in
            rootViewController?.pageViewModel = PageViewModelMapper.map(question)
        }
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}

