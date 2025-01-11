//
//  SingleChoiceQuestionService.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/10/25.
//

protocol SingleChoiceQuestionService {
    func getSingleChoiceQuestion(_ completion: @escaping (SingleChoiceQuestion) -> Void)
}
