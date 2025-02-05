//
//  SingleChoiceAnswerServiceAsyncDecorator.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 2/4/25.
//

import Foundation

final class SingleChoiceAnswerServiceAsyncDecorator: SingleChoiceAnswerService {

    func submitSingleChoiceAnswer(_ answer: SingleChoiceAnswer, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [decoratee] in
            decoratee.submitSingleChoiceAnswer(answer, completion: completion)
        }
    }

    private let decoratee: SingleChoiceAnswerService

    init(decoratee: SingleChoiceAnswerService) {
        self.decoratee = decoratee
    }
}
