//
//  AuthenticationService.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 21/09/24.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel: Equatable {
    let uid: String
    let providerID: String
    let email: String?
    let name: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.providerID = user.providerID
        self.name = user.displayName
    }
}

final class AuthenticationService {
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(credential: credential)
    }
    
    @discardableResult
    func signInWithApple(tokens: SignInWithAppleResult) async throws -> AuthDataResultModel {
        let credential = OAuthProvider.credential(providerID: AuthProviderID.apple, idToken: tokens.token, rawNonce: tokens.nonce)
        return try await signIn(credential: credential)
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func logOut() throws {
        try Auth.auth().signOut()
    }
}
