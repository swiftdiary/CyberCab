//
//  QuestionsObservable.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 21/09/24.
//

import Foundation
import SwiftUI

@Observable
final class QuestionsObservable {
    var allQuestions = [Question]()
    var currentQuestionIndex: Int = 0
    
    var answers: [Answer] = []
    
    var hasAnsweredAllQuestions: Bool = false
    
    var answerText: String?
    var answerInt: Int?
    var answerFloat: Double?
    var answerChoicesList: [AnswerChoice] = []
    
    @ObservationIgnored private let questionsManager = FirestoreManager<Question>()
    
    func getAllQuestions() async throws {
        let questions = try await questionsManager.getDocuments(queries: [.orderBy(field: "questionNo", descending: false)])
        print("Questions: \(questions)")
        await MainActor.run {
            self.allQuestions = questions
        }
    }
    
    @MainActor
    func nextQuestion() {
        print("Next question")
        if currentQuestionIndex < allQuestions.count {
            print("Next question: \(currentQuestionIndex)")
            let question = allQuestions[currentQuestionIndex]
            answers.append(Answer(
                questionId: question.id,
                answerText: answerText,
                answerInt: answerInt,
                answerFloat: answerFloat,
                choicesList: answerChoicesList
            ))
            print(answers, separator: "\n")
            answerText = nil
            answerInt = nil
            answerFloat = nil
            answerChoicesList = []
            if currentQuestionIndex != allQuestions.count - 1 {
                currentQuestionIndex += 1
            } else {
                Task {
                    do {
                        try await submitAnswers()
                    } catch {
                        print(error)
                    }
                }
            }
        } else {
            Task {
                do {
                    try await submitAnswers()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func submitAnswers() async throws {
        for answer in answers {
            try await answer.save()
        }
        await MainActor.run {
            hasAnsweredAllQuestions = true
        }
    }
}
