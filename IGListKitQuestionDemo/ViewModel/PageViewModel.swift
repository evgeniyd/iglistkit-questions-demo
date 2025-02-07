//
//  PageViewModel.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 2/6/25.
//

import IGListKit

final class PageViewModel {

    let title = "Many"
    let ctaTitle = "Submit"
    let questionWithOptions: QuestionWithOptionsViewModel

    init(questionWithOptions: QuestionWithOptionsViewModel) {
        self.questionWithOptions = questionWithOptions
    }
}

// MARK: - ListDiffable

extension PageViewModel: ListDiffable {
    func diffIdentifier() -> any NSObjectProtocol {
        return questionWithOptions.questionViewModel.id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: (any ListDiffable)?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? QuestionWithOptionsViewModel else { return false }
        return questionWithOptions.isEqual(toDiffableObject: object)
    }
}
