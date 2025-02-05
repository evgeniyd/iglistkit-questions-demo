//
//  SingleChoiceAnswerService.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 2/4/25.
//

import Foundation

protocol SingleChoiceAnswerService {
    func submitSingleChoiceAnswer(_ answer: SingleChoiceAnswer, completion: @escaping () -> Void)
}
