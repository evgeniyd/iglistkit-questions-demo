//
//  SingleChoiceQuestionServiceImpl.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/10/25.
//

import Foundation

final class SingleChoiceQuestionServiceImpl: SingleChoiceQuestionService {

    func getSingleChoiceQuestion(_ completion: @escaping (SingleChoiceQuestion) -> Void) {
        // Generate a random number of options between 2 and 10
        let numberOfOptions = Int.random(in: 2...6)

        // Create the options dynamically
        var options: [SingleChoiceQuestion.Option] = []
        for _ in 0..<numberOfOptions {
            let option = SingleChoiceQuestion.Option(title: generateRandomOption())
            options.append(option)
        }

        // Generate the question
        let question = SingleChoiceQuestion(
            title: generateRandomQuestion(),
            options: options,
            id: Int.random(in: 0...Int.max)
        )

        completion(question)
    }

    // MARK: - Private

    // Helper method to generate random text for a question
    private func generateRandomQuestion() -> String {
        let characters = "abcdefghijklmnopqrstuvwxyz"
        let wordCount = Int.random(in: 5...10) // Random number of words in the question

        var words: [String] = []

        for _ in 0..<wordCount {
            let wordLength = Int.random(in: 3...8) // Random word length between 3 and 8
            let word = (0..<wordLength).map { _ in
                String("\(characters.randomElement()!)")
            }.joined()
            words.append(word)
        }

        // Combine words with spaces
        var text = words.joined(separator: " ")

        // Capitalize the first letter and add a "?" at the end
        text = text.prefix(1).capitalized + text.dropFirst()
        return text + "?"
    }

    // Helper method to generate random text for an option
    private func generateRandomOption() -> String {
        let characters = "abcdefghijklmnopqrstuvwxyz"
        let wordCount = Int.random(in: 1...3) // Random number of words in the option

        var words: [String] = []

        for _ in 0..<wordCount {
            let wordLength = Int.random(in: 3...8) // Random word length between 3 and 8
            let word = (0..<wordLength).map { _ in
                String("\(characters.randomElement()!)")
            }.joined()
            words.append(word)
        }

        // Combine words with spaces
        var text = words.joined(separator: " ")

        // Capitalize the first letter
        text = text.prefix(1).capitalized + text.dropFirst()
        return text
    }

}
