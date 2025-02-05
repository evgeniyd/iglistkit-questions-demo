//
//  OptionViewModel.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/10/25.
//

import IGListKit

final class OptionViewModel {

    init(title: String, questionId: Int, selection: @escaping () -> Void) {
        self.title = title
        self.questionId = questionId
        self.select = selection
    }

    let title: String
    let questionId: Int
    let select: () -> Void
}

// MARK: - ListDiffable

extension OptionViewModel: ListDiffable {
    func diffIdentifier() -> any NSObjectProtocol {
        return NSString(string: title)
    }

    func isEqual(toDiffableObject object: (any ListDiffable)?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? OptionViewModel else { return false }
        return self.questionId == object.questionId && self.title == object.title
    }
}
