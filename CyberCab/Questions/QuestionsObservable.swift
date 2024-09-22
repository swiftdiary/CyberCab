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
    var member: Member?
    
    var allQuestions = [Question]()
    var currentQuestionIndex: Int = 0
    
    var answers: [Answer] = []
    
    var hasAnsweredAllQuestions: Bool = false
    
    var answerText: String?
    var answerInt: Int?
    var answerFloat: Double?
    var answerChoicesList: [AnswerChoice] = []
    
    @ObservationIgnored private let questionsManager = FirestoreManager<Question>()
    @ObservationIgnored private let authenticationService = AuthenticationService()
    @ObservationIgnored private let memberManager = FirestoreManager<Member>()
    
    func getUser() async throws {
        let authData = try authenticationService.getAuthenticatedUser()
        let member = try await memberManager.getDocument(id: authData.uid)
        await MainActor.run {
            self.member = member
        }
    }
    
    func getAllQuestions() async throws {
        let questions = try await questionsManager.getDocuments(queries: [.orderBy(field: "questionNo", descending: false)])
        print("Questions: \(questions)")
        await MainActor.run {
            self.allQuestions = questions
        }
    }
    
    @MainActor
    func nextQuestion() {
        guard let member else { return }
        print("Next question")
        if currentQuestionIndex < allQuestions.count {
            print("Next question: \(currentQuestionIndex)")
            let question = allQuestions[currentQuestionIndex]
            answers.append(Answer(
                questionId: question.id,
                memberId: member.id,
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
