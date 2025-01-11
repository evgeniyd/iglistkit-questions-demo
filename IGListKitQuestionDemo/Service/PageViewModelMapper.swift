//
//  PageViewModelMapper.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/11/25.
//

final class PageViewModelMapper {

    static func map(_ question: SingleChoiceQuestion) -> PageViewModel {
        let optionVMs = question.options.map { OptionViewModel(title: $0.title, questionId: question.id) }
        return PageViewModel(questionViewModel: QuestionViewModel(title: question.title, id: question.id), optionViewModels: optionVMs)
    }
}
