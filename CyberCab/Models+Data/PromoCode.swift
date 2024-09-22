//
//  PromoCode.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 22/09/24.
//

import Foundation

struct PromoCode: Firestorable {
    let id: String
    var createdAt: Date
    static let collectionReferenceName: String = "promo-codes"
    
    var name: String
    var discount: Int
    var expireDate: Date
}
