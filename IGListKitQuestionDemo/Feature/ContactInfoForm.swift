//
//  ContactInfoForm.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 2/8/25.
//

struct ContactInfoForm: Identifiable {
    let id: Int
    let firstName: ShortTextQuestion?
    let lastName: ShortTextQuestion?
    let city: ShortTextQuestion?
    let email: ShortTextQuestion?
    let phone: ShortTextQuestion?
    let address: ShortTextQuestion?
    let zipCode: ShortTextQuestion?
    let state: ShortTextQuestion?
    let country: ShortTextQuestion?
}
