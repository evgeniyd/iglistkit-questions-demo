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
            viewController?.pageViewModel = PageViewModelMapper.map(question)
        }
        return viewController
    }
}
