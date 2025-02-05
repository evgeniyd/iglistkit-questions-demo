//
//  SingleChoiceAnswer.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 2/4/25.
//

import Foundation

struct SingleChoiceAnswer: Identifiable {
    let timestamp: Date
    let id: Int
    let questionId: Int
    let selectedOptionId: Int

    init(questionId: Int, selectedOptionId: Int) {
        self.questionId = questionId
        self.selectedOptionId = selectedOptionId
        self.timestamp = Date()
        self.id = Int.random(in: 0...Int.max)
    }
}
