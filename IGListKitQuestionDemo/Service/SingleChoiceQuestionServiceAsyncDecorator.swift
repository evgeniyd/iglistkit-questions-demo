//
//  SingleChoiceQuestionServiceAsyncDecorator.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/11/25.
//

import Foundation

final class SingleChoiceQuestionServiceAsyncDecorator: SingleChoiceQuestionService {

    func getSingleChoiceQuestion(_ completion: @escaping (SingleChoiceQuestion) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [decoratee] in
            decoratee.getSingleChoiceQuestion(completion)
        }
    }

    private let decoratee: SingleChoiceQuestionService

    init(decoratee: SingleChoiceQuestionService) {
        self.decoratee = decoratee
    }
}
