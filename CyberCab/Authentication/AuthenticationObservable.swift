//
//  AuthenticationObservable.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 21/09/24.
//

import Foundation

@Observable
final class AuthenticationObservable {
    var isAuthenticated: Bool = false
    
    @ObservationIgnored private let authenticationService = AuthenticationService()
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let authDataResult = try await authenticationService.signInWithGoogle(tokens: tokens)
        try await syncInFirestore(with: authDataResult)
    }
    
    func signInApple() async throws {
        let helper = await SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        let authDataResult = try await authenticationService.signInWithApple(tokens: tokens)
        try await syncInFirestore(with: authDataResult)
    }
    
    func syncInFirestore(with authDataResult: AuthDataResultModel) async throws {
        guard let memberEmail = authDataResult.email else { throw AuthenticationViewModelError.noEmail }
        let newMember = Member(id: authDataResult.uid, email: memberEmail, name: authDataResult.name ?? "Anonymous")
        try await newMember.save()
        await MainActor.run {
            isAuthenticated = true
        }
    }
}

enum AuthenticationViewModelError: Error {
    case noEmail
}
