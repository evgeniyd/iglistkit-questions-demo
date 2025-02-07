//
//  QuestionViewModel.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/11/25.
//

import IGListKit

final class QuestionViewModel: Identifiable {

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
        guard self !== object else { return true }
        guard let object = object as? QuestionViewModel else { return false }
        return self.id == object.id && self.title == object.title
    }
}
