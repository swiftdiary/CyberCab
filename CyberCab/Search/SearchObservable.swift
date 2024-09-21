//
//  SearchObservable.swift
//  CyberCab
//
//  Created by Muhammadjon Madaminov on 22/09/24.
//

import Foundation



@Observable
final class SearchObservable {
    var cabs: [Cab] = []
    let cabManager = FirestoreManager<Cab>()
    
    var searchText: String = ""
    
    func getCabs() async throws {
        let cabs = try await cabManager.getDocuments(queries: [.orderBy(field: "name", descending: false)])
        
        await MainActor.run {
            self.cabs = cabs
        }
    }
}
