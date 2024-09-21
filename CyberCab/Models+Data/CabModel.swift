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
    let name: AppLocalizable
    let image: String
    let profession: AppLocalizable
    let content: [CabContent]
    let maxMembers: Int
    let status: CabStatus
    
    // Enum to represent different statuses of the cab
    enum CabStatus: String, Codable {
        case active
        case inactive
    }
}

struct CabContent: Codable, Hashable {
    let type: CabContentType
    let image: String?
    let paragraph: String?
    let heading: String?
    let arItem: String?
    
    enum CabContentType: String, Codable {
        case paragraph
        case image
        case heading
        case arItem
    }
}
