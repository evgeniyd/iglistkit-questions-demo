//
//  PageViewModelMapper.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/11/25.
//

final class QuestionWithOptionsViewModelMapper {

    static func map(_ question: SingleChoiceQuestion, selection: @escaping (SingleChoiceQuestion.Option) -> Void ) -> QuestionWithOptionsViewModel {
        return QuestionWithOptionsViewModel(question: question, selection: selection)
    }
}

// MARK: - Adapter

extension OptionViewModel {
    convenience init(option: SingleChoiceQuestion.Option, question: SingleChoiceQuestion, selection: @escaping () -> Void) {
        self.init(title: option.title, questionId: question.id, selection: selection)
    }
}

extension QuestionWithOptionsViewModel {
    convenience init(question: SingleChoiceQuestion, selection: @escaping (SingleChoiceQuestion.Option) -> Void) {
        self.init(questionViewModel: QuestionViewModel(title: question.title, id: question.id),
                  optionViewModels: question.options.map { option in
            OptionViewModel(option: option, question: question, selection: { selection(option) })
        })
    }
}
