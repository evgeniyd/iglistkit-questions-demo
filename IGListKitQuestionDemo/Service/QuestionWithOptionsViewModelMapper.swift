//
//  PageViewModelMapper.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/11/25.
//

final class QuestionWithOptionsViewModelMapper {

    static func map(_ question: SingleChoiceQuestion, selection: @escaping (SingleChoiceQuestion.Option) -> Void, verification: @escaping (SingleChoiceQuestion) -> Bool) -> QuestionWithOptionsViewModel {
        return QuestionWithOptionsViewModel(question: question, selection: selection, verification: verification)
    }
}
