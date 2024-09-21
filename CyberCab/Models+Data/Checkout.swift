//
//  Checkout.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 22/09/24.
//

import Foundation

struct Checkout: Firestorable {
    let id: String
    var createdAt: Date
    static let collectionReferenceName: String = "checkouts"
    
    var paymentMethod: String
    var billingInfo: BillingInfo
    var status: CheckoutStatus
    var paidAt: Date?
    
    enum CheckoutStatus: String, Codable {
        case pending
        case completed
        case failed
    }
}

struct BillingInfo: Codable, Hashable {
    var amount: Int
}
