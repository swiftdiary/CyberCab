//
//  AuthenticationView.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 21/09/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct AuthenticationView: View {
    
    @State private var authenticationObservable = AuthenticationObservable()
    @AppStorage("isAuthenticated") private var isAuthenticated: Bool = false
    
    var body: some View {
        @Bindable var authenticationObservable = authenticationObservable
        VStack {
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                Task {
                    do {
                        try await authenticationObservable.signInGoogle()
                    } catch {
                        print(error)
                    }
                }
            }
            .padding()
            
            // Required Apple Developer Account to test !!!
//            Button(action: {
//                Task {
//                    do {
//                        try await authenticationObservable.signInApple()
//                    } catch {
//                        print(error)
//                    }
//                }
//            }, label: {
//                SignInWithAppleButtonViewRepresentable(type: .continue, style: .black)
//                    .allowsHitTesting(false)
//            })
//            .frame(height: 45)
//            .padding()
        }
        .onChange(of: authenticationObservable.isAuthenticated) {oldValue, newValue in
            if newValue {
                isAuthenticated = true
            }
        }
    }
}

#Preview {
    AuthenticationView()
}
