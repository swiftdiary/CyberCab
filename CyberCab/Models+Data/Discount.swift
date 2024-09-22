//
//  Discount.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 22/09/24.
//

import Foundation

struct Discount: Firestorable {
    let id: String
    var createdAt: Date
    static let collectionReferenceName: String = "discounts"
    
    var memberId: String
    var discount: Int
    var expireDate: Date
    
}
