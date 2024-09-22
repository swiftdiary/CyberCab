//
//  Answer.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 21/09/24.
//

import Foundation

struct Answer: Firestorable {
    let id: String
    var createdAt: Date
    static let collectionReferenceName: String = "answers"
    
    let questionId: String
    let memberId: String
    var answerText: String?
    var answerInt: Int?
    var answerFloat: Double?
    var choicesList: [AnswerChoice]? // For multiple answer multiple choice
    
    init(questionId: String, memberId: String, answerText: String? = nil, answerInt: Int? = nil, answerFloat: Double? = nil, choicesList: [AnswerChoice]? = nil) {
        self.id = UUID().uuidString
        self.memberId = memberId
        self.createdAt = Date()
        self.questionId = questionId
        self.answerText = answerText
        self.answerInt = answerInt
        self.answerFloat = answerFloat
        self.choicesList = choicesList
    }
    
}
