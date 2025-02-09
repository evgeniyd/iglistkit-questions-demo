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
    var errorMessage: String = ""
    private(set) var text: String?

    init(title: String, placeholder: String) {
        self.title = title
        self.placeholder = placeholder
    }

    func didChange(_ text: String?) {
        self.text = text
    }
}

// MARK: - ListDiffable

extension TextViewViewModel: ListDiffable {
    func diffIdentifier() -> any NSObjectProtocol {
        return NSString(string: title)
    }

    func isEqual(toDiffableObject object: (any ListDiffable)?) -> Bool {
        guard self !== object else { return true }
        guard let object = object as? TextViewViewModel else { return false }
        return self.placeholder == object.placeholder
        && self.title == object.title
        && self.errorMessage == object.errorMessage
        && self.text == object.text
    }
}
