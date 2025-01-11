//
//  SingleChoiceQuestionServiceImpl.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/10/25.
//


final class SingleChoiceQuestionServiceImpl: SingleChoiceQuestionService {
    
    func getSingleChoiceQuestion(_ completion: @escaping (SingleChoiceQuestion) -> Void) {
        let option1 = SingleChoiceQuestion.Option(title: "Option 1")
        let option2 = SingleChoiceQuestion.Option(title: "Option 2")
        let option3 = SingleChoiceQuestion.Option(title: "Option 3")

        let question = SingleChoiceQuestion(title: "What would you choose?", options: [option1, option2, option3])

        completion(question)
    }
}
