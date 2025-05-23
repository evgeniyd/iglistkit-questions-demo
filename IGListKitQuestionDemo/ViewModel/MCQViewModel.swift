//
//  MCQViewModel.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 2/6/25.
//

import Foundation

final class MCQViewModel {

    enum State {
        case questionWithOptionsViewModel
    }
    var onChangeState: ((MCQViewModel, State) -> Void)?

    let submitButtonTitle = "Submit"
    var questionWithOptionsViewModel: QuestionWithOptionsViewModel? {
        didSet {
            self.onChangeState?(self, .questionWithOptionsViewModel)
        }
    }

    init() {}

    func didTapCTA() {
        guard let questionWithOptionsViewModel else {
            return
        }
        if questionWithOptionsViewModel.verify() {
            self.questionWithOptionsViewModel = nil
        } else {
            questionWithOptionsViewModel.errorMessage = "You must select an option!"
            self.onChangeState?(self, .questionWithOptionsViewModel)
        }
    }
}
