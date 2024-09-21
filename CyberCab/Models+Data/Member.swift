//
//  Member.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 21/09/24.
//

import Foundation

struct Member: Firestorable {
    let id: String
    var createdAt: Date
    static let collectionReferenceName: String = "members"
    
    var email: String
    var name: String
    var state: MemberState = .none
    
    init(id: String, email: String, name: String) {
        self.id = id
        self.createdAt = Date()
        self.email = email
        self.name = name
    }
    
    enum MemberState: String, Codable {
        case none
        
    }
}
