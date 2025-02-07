//
//  PageViewModel.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 2/6/25.
//

import IGListKit

final class PageViewModel {

    enum State {
        case questionWithOptionsViewModel
    }
    var onChangeState: ((PageViewModel, State) -> Void)?

    let submitButtonTitle = "Submit"
    var questionWithOptionsViewModel: QuestionWithOptionsViewModel? {
        didSet {
            self.onChangeState?(self, .questionWithOptionsViewModel)
        }
    }

    init() {}
}
