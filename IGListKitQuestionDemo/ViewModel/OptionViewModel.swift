//
//  OptionViewModel.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/10/25.
//

import IGListKit

final class OptionViewModel {

    init(title: String, questionId: Int) {
        self.title = title
        self.questionId = questionId
    }

    let title: String
    let questionId: Int
}

// MARK: - ListDiffable

extension OptionViewModel: ListDiffable {
    func diffIdentifier() -> any NSObjectProtocol {
        return NSString(string: title)
    }

    func isEqual(toDiffableObject object: (any ListDiffable)?) -> Bool {
        if let object = object as? OptionViewModel {
            return self.questionId == object.questionId
        }
        return false
    }
}
