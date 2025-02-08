//
//  TextFieldViewModel.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 2/7/25.
//

import IGListKit

final class TextFieldViewModel {
    let placeholder: String

    init(placeholder: String) {
        self.placeholder = placeholder
    }
}

// MARK: - ListDiffable

extension TextFieldViewModel: ListDiffable {
    func diffIdentifier() -> any NSObjectProtocol {
        return NSString(string: placeholder)
    }

    func isEqual(toDiffableObject object: (any ListDiffable)?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? TextFieldViewModel else { return false }
        return self.placeholder == object.placeholder
    }
}
