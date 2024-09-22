//
//  ProfileViewObservable.swift
//  CyberCab
//
//  Created by Muhammadjon Madaminov on 21/09/24.
//


import SwiftUI


@Observable
final class ProfileViewObservable {
    var member: Member?
    var sessions: [Session] = []
    
    @ObservationIgnored let memberManager = FirestoreManager<Member>()
    @ObservationIgnored let sessionsManager = FirestoreManager<Session>()
    @ObservationIgnored let authManager = AuthenticationService()
    
    func getMember() async throws {
        let member = try await memberManager.getDocument(id: authManager.getAuthenticatedUser().uid)
        await MainActor.run {
            self.member = member
        }
    }
    
}
