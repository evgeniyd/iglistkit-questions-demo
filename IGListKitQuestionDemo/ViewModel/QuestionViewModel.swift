//
//  QuestionViewModel.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/11/25.
//

import IGListKit

final class QuestionViewModel {

    init(title: String, id: Int) {
        self.title = title
        self.id = id
    }

    let title: String
    let id: Int
}

// MARK: - ListDiffable

extension QuestionViewModel: ListDiffable {
    func diffIdentifier() -> any NSObjectProtocol {
        return NSNumber(integerLiteral: id)
    }

    func isEqual(toDiffableObject object: (any ListDiffable)?) -> Bool {
        if let object = object as? QuestionViewModel {
            return self.title == object.title
        }
        return false
    }
}
