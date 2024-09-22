//
//  Question.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 21/09/24.
//

import Foundation

struct Question: Firestorable {
    let id: String
    var createdAt: Date
    static let collectionReferenceName: String = "questions"
    
    let questionNo: Int
    let type: QuestionType
    let text: AppLocalizable
    let image: String?
    let choices: [AnswerChoice]
    
    enum QuestionType: String, Codable, CaseIterable {
        case multipleChoice
        case multipleChoiceWithMultipleAnswers
        case multipleChoiceOrText
        case text
        case int
        case float
    }
}

// Also used in Answer (answers collection)
struct AnswerChoice: Codable, Hashable {
    let int: Int?
    let text: AppLocalizable?
    let float: Double?
}
