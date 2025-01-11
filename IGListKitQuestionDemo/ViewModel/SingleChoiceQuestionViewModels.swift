//
//  SingleChoiceQuestionViewModels.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/10/25.
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

final class OptionViewModel {

    init(title: String, questionId: Int) {
        self.title = title
        self.questionId = questionId
    }

    let title: String
    let questionId: Int
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
