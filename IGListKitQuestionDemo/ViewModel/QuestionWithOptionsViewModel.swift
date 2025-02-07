//
//  PageViewModel.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/10/25.
//

import IGListKit

final class QuestionWithOptionsViewModel {
    
    init(questionViewModel: QuestionViewModel, optionViewModels: [OptionViewModel]) {
        self.questionViewModel = questionViewModel
        self.optionViewModels = optionViewModels
    }

    let questionViewModel: QuestionViewModel
    let optionViewModels: [OptionViewModel]
}

// MARK: - ListDiffable

extension QuestionWithOptionsViewModel: ListDiffable {
    func diffIdentifier() -> any NSObjectProtocol {
        return questionViewModel.id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: (any ListDiffable)?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? QuestionWithOptionsViewModel else { return false }
        return questionViewModel.isEqual(toDiffableObject: object.questionViewModel) &&
        optionViewModels.count == object.optionViewModels.count &&
        zip(optionViewModels, object.optionViewModels).allSatisfy { option1, option2 in
            option1.isEqual(toDiffableObject: option2)
        }
    }
}
