//
//  QuestionWithOptionsViewModelAdapter.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 2/8/25.
//

import Foundation

extension OptionViewModel {
    convenience init(option: SingleChoiceQuestion.Option, question: SingleChoiceQuestion, selection: @escaping () -> Void) {
        self.init(title: option.title, questionId: question.id, selection: selection)
    }
}

extension QuestionWithOptionsViewModel {
    convenience init(question: SingleChoiceQuestion, selection: @escaping (SingleChoiceQuestion.Option) -> Void, verification: @escaping (SingleChoiceQuestion) -> Bool) {
        self.init(questionViewModel: QuestionViewModel(title: question.title, id: question.id),
                  optionViewModels: question.options.map { option in
            OptionViewModel(option: option, question: question, selection: { selection(option) })
        }, verification: { verification(question) })
    }
}
