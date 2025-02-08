//
//  TextViewViewModel.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 2/8/25.
//

import IGListKit

final class TextViewViewModel {
    let placeholder: String
    let title: String

    init(title: String, placeholder: String) {
        self.title = title
        self.placeholder = placeholder
    }
}

// MARK: - ListDiffable

extension TextViewViewModel: ListDiffable {
    func diffIdentifier() -> any NSObjectProtocol {
        return NSString(string: title+placeholder)
    }

    func isEqual(toDiffableObject object: (any ListDiffable)?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? TextViewViewModel else { return false }
        return self.placeholder == object.placeholder && self.title == object.title
    }
}
