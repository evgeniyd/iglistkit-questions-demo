//
//  PageViewModelMapper.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/11/25.
//

final class PageViewModelMapper {

    static func map(_ question: SingleChoiceQuestion) -> PageViewModel {
        return PageViewModel(question: question)
    }
}

// MARK: - Adapter

extension OptionViewModel {
    convenience init(option: SingleChoiceQuestion.Option, question: SingleChoiceQuestion) {
        self.init(title: option.title, questionId: question.id)
    }
}

extension PageViewModel {
    convenience init(question: SingleChoiceQuestion) {
        self.init(questionViewModel: QuestionViewModel(title: question.title, id: question.id),
                  optionViewModels: question.options.map { OptionViewModel(option: $0, question: question) })
    }
}
