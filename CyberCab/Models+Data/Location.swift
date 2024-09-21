//
//  Location.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 22/09/24.
//

import Foundation

struct Location: Firestorable {
    let id: String
    var createdAt: Date
    static let collectionReferenceName: String = "locations"
    
    var name: AppLocalizable
    var longitude: Double
    var latitude: Double
    var town: AppLocalizable
}
