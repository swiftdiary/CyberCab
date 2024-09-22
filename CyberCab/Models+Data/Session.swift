//
//  Session.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 22/09/24.
//

import Foundation

// MARK: - Session Model
struct Session: Firestorable {
    static var collectionReferenceName: String = "sessions"
    var createdAt: Date
    
    let id: String
    let availableHourId: String
    let memberId: String
    var scheduleDate: Date
    var status: SessionStatus
    
    init(availableHourId: String, memberId: String, scheduleDate: Date, status: SessionStatus) {
        self.createdAt = Date()
        self.id = UUID().uuidString
        self.availableHourId = availableHourId
        self.memberId = memberId
        self.scheduleDate = scheduleDate
        self.status = status
    }
    
    // Enum to represent different session statuses
    enum SessionStatus: String, Codable {
        case scheduled
        case completed
        case canceled
    }
}
