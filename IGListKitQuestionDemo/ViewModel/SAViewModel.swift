//
//  SAViewModel.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 2/8/25.
//

import Foundation

final class SAViewModel {

    enum State {
        case textViewViewModel
    }
    var onChangeState: ((SAViewModel, State) -> Void)?

    let title = "SA"
    let submitButtonTitle = "Submit"
    let textViewViewModel: TextViewViewModel
    let verify: (String?) -> Bool

    init(textViewViewModel: TextViewViewModel, verification: @escaping (String?) -> Bool) {
        self.textViewViewModel = textViewViewModel
        self.verify = verification
    }

    func didTapCTA() {
        guard verify(self.textViewViewModel.text) else {
            self.textViewViewModel.errorMessage = "Please tell your story"
            onChangeState?(self, .textViewViewModel)
            return
        }
        
        self.textViewViewModel.errorMessage = ""
        onChangeState?(self, .textViewViewModel)
    }
}

