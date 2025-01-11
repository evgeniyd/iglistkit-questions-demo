//
//  PageViewModel.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/10/25.
//

import Foundation

final class PageViewModel {
    
    init(questionViewModel: QuestionViewModel, optionViewModels: [OptionViewModel]) {
        self.questionViewModel = questionViewModel
        self.optionViewModels = optionViewModels
    }

    let questionViewModel: QuestionViewModel
    let optionViewModels: [OptionViewModel]
}
