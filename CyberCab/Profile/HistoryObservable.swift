//
//  HistoryObservable.swift
//  CyberCab
//
//  Created by Muhammadjon Madaminov on 22/09/24.
//

import Foundation


@Observable
final class HistoryObservable {
    var sessions: [Session] = []
    
    let sessionsManager = FirestoreManager<Session>()
    let availableHoursManager = FirestoreManager<AvailableHour>()
    let cabManager = FirestoreManager<Cab>()
    
    func getSessions(member: Member?) async throws {
        guard let member else { return }
        let sessions = try await sessionsManager.getDocuments(queries: [.isEqualTo(field: "memberId", value: member.id)])
        
        await MainActor.run {
            self.sessions = sessions
        }
    }
}
