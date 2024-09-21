//
//  Firestorable.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 21/09/24.
//

import Foundation

protocol Firestorable: Identifiable, Hashable, Codable {
    var id: String { get }
    static var collectionReferenceName: String { get }
    var createdAt: Date { get }
    
    func save() async throws
}

extension Firestorable {
    func save() async throws {
        let firestoreManager = FirestoreManager<Self>()
        try await firestoreManager.saveDocument(id: self.id, data: self)
    }
}
