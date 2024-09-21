//
//  CabModel.swift
//  CyberCab
//
//  Created by Muhammadjon Madaminov on 21/09/24.
//

import Foundation



// MARK: - Cab Model
struct Cab: Firestorable {
    static var collectionReferenceName: String = "cabs"
    var createdAt: Date
    
    let id: String
    let locationId: String
    let name: String
    let image: String
    let profession: String
    let content: [String]
    let maxMembers: Int
    let status: CabStatus
    
    // Enum to represent different statuses of the cab
    enum CabStatus: String, Codable {
        case active
        case inactive
    }
}


// MARK: - Session Model
struct Session: Firestorable {
    static var collectionReferenceName: String = "sessions"
    var createdAt: Date
    
    let id: String
    let availableHourId: String
    let memberId: String
    let scheduleDate: Date
    let status: SessionStatus
    
    // Enum to represent different session statuses
    enum SessionStatus: String, Codable {
        case scheduled
        case completed
        case canceled
    }
}

// MARK: - AvailableHour Model
struct AvailableHour: Firestorable {
    static var collectionReferenceName: String = "availableHours"
    var createdAt: Date
    
    let id: String
    let cabId: String
    let duration: TimeInterval
    let weekday: Weekday
    let time: Date
    let price: Int
    
    // Enum to represent the days of the week
    enum Weekday: String, CaseIterable, Codable {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }
}
