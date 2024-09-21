//
//  FirestoreManager.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 21/09/24.
//

import Foundation
import FirebaseFirestore

actor FirestoreManager<T: Firestorable> {
    let collectionReference: CollectionReference = Firestore.firestore().collection(T.collectionReferenceName)
    
    func document(id: String) -> DocumentReference {
        collectionReference.document(id)
    }
    
    func saveDocument(id: String, data: T) throws {
        try document(id: id).setData(from: data, merge: true)
    }
    
    func deleteDocument(id: String) {
        document(id: id).delete()
    }
    
    func getDocument(id: String) async throws -> T? {
        try? await document(id: id).getDocument(as: T.self)
    }
    
    func getDocuments(queries: [FFQuery]) async throws -> [T] {
        let builder = FFQueryBuilder(queries: queries)
        let query = builder.buildQuery(for: self.collectionReference)
        let snapshot = try await query.getDocuments()
        return try snapshot.documents.map({ try $0.data(as: T.self )})
    }
}
