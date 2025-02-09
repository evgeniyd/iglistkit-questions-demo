//
//  ContactInfoViewModel.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 2/8/25.
//

import Foundation

final class ContactInfoViewModel {

    let title = "Contact Info"
    let submitButtonTitle = "Submit"
    let contactInfoViewModels: [TextFieldViewModel]

    init(contactInfoViewModels: [TextFieldViewModel]) {
        self.contactInfoViewModels = contactInfoViewModels
    }

    func didTapCTA() {

    }
}
