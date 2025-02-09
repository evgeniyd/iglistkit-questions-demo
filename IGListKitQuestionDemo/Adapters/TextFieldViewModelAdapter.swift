//
//  TextFieldViewModelAdapter.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 2/8/25.
//

import Foundation

extension TextFieldViewModel {
    convenience init(shortTextQuestion: ShortTextQuestion) {
        self.init(title: shortTextQuestion.title, placeholder: shortTextQuestion.placeholder)
    }
}
