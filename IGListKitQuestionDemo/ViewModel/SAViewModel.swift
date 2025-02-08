//
//  SAViewModel.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 2/8/25.
//

import Foundation

final class SAViewModel {

    let submitButtonTitle = "Submit"
    let textViewViewModel: TextViewViewModel

    init(textViewViewModel: TextViewViewModel) {
        self.textViewViewModel = textViewViewModel
    }
}

