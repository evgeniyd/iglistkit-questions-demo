//
//  Question.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/10/25.
//

import Foundation

struct SingleChoiceQuestion: Identifiable {

    struct Option: Identifiable {
        let title: String
        let id: Int
    }

    let title: String
    let options: [Option]
    let id: Int
}
