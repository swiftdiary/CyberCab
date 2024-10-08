//
//  AvailableHour.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 22/09/24.
//

import Foundation

// MARK: - AvailableHour Model
struct AvailableHour: Firestorable {
    static var collectionReferenceName: String = "available-hours"
    var createdAt: Date
    
    let id: String
    let cabId: String
    let duration: TimeInterval
    let weekday: Int
    let time: String
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case createdAt
        case id
        case cabId = "cabin_id"
        case duration
        case weekday
        case time
        case price
    }
}
