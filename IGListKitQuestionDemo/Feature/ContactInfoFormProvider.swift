//
//  ContactInfoFormProvider.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 2/8/25.
//

protocol ContactInfoFormProvider {
    func getContactInfoForm(_ completion: @escaping (ContactInfoForm) -> Void)
}
