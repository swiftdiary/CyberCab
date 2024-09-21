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
    
    // Enum to represent different session statuses
    enum SessionStatus: String, Codable {
        case scheduled
        case completed
        case canceled
    }
}
