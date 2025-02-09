//
//  ContactInfoFormProviderImpl.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 2/8/25.
//

import Foundation

final class ContactInfoFormProviderImpl: ContactInfoFormProvider {
    func getContactInfoForm(_ completion: @escaping (ContactInfoForm) -> Void) {
        let form = ContactInfoForm(
            id: Int.random(in: 0...Int.max),
            firstName: ShortTextQuestion(title: "First Name", placeholder: "Enter your first name", id: 1),
            lastName: ShortTextQuestion(title: "Last Name", placeholder: "Enter your last name", id: 2),
            city: ShortTextQuestion(title: "City", placeholder: "Enter your city", id: 3),
            email: ShortTextQuestion(title: "Email", placeholder: "Enter your email", id: 4),
            phone: ShortTextQuestion(title: "Phone", placeholder: "Enter your phone number", id: 5),
            address: ShortTextQuestion(title: "Address", placeholder: "Enter your address", id: 6),
            zipCode: ShortTextQuestion(title: "Zip Code", placeholder: "Enter your zip code", id: 7),
            state: ShortTextQuestion(title: "State", placeholder: "Enter your state", id: 8),
            country: ShortTextQuestion(title: "Country", placeholder: "Enter your country", id: 9)
        )

        completion(form)
    }
}

