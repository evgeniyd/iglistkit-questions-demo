//
//  Question.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/10/25.
//

struct SingleChoiceQuestion {

    struct Option {
        let title: String
    }

    let title: String
    let options: [Option]
}
