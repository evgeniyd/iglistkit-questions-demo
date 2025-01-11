//
//  Question.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/10/25.
//

struct SingleChoiceQuestion: Identifiable {

    struct Option {
        let title: String
    }

    let title: String
    let options: [Option]
    let id: Int
}
