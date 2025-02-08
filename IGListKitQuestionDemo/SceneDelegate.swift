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

        window?.rootViewController = ViewControllersFactory.createTabBar(viewController1: ViewControllersFactory.createOneSectionControllerExampleViewController(),
                                                                         viewController2: ViewControllersFactory.createTwoSectionControllersExampleViewController(),
                                                                         viewController3: ViewControllersFactory.createManySectionControllerExampleViewController(),
                                                                         viewController4: ViewControllersFactory.createTextFieldSectionControllersExampleViewController())
        window?.makeKeyAndVisible()
    }
}

