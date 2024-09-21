//
//  ProfileView.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 21/09/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var profileObservable = ProfileViewObservable()
    @Environment(CustomNavigation.self) var customNavigation
    @AppStorage("isAuthenticated") private var isAuthenticated: Bool = false
    
    let authService = AuthenticationService()
    
    var body: some View {
        @Bindable var profileObservable = profileObservable
        @Bindable var customNavigation = customNavigation
        
        ZStack {
            Color.csBackground.ignoresSafeArea()
            
            if let member = profileObservable.member {
                VStack(spacing: 20) {
                    userNameLabel(member: member)
                        .padding(.leading)
                    
                    settingsOptions(member: member)
                    
                    Spacer()
                }
                .padding(.top, 10)
            } else {
                ProgressView()
            }
        }
        .environment(customNavigation)
        .task {
            await loadProfileData()
        }
    }
    
    // MARK: - Load Profile Data
    private func loadProfileData() async {
        do {
            try await profileObservable.getMember()
        } catch {
            print("Failed to load profile data: \(error)")
        }
    }
}

// MARK: - Extensions with @ViewBuilder
extension ProfileView {
    
    // MARK: - Settings Options View
    @ViewBuilder
    func settingsOptions(member: Member) -> some View {
        VStack {
            List {
                settingsOptionRow(title: "History", systemImage: "clock.fill", color: .blue, nav: .history(memvber: member))
                
                contactLinkRow()
                
                settingsOptionRow(title: "Privacy Policy", systemImage: "lock.shield.fill", color: .purple, nav: .privacyPolicy)
                settingsOptionRow(title: "Terms of Use", systemImage: "doc.text.fill", color: .orange, nav: .termsOfService)
                
                logOutButton()
            }
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .font(.system(size: 22, weight: .medium))
            .foregroundStyle(Color.primary)
        }
    }
    
    // MARK: - Log Out Button
    @ViewBuilder
    func logOutButton() -> some View {
        Button {
            do {
                try authService.logOut()
                isAuthenticated = false
            } catch {
                print("Logout failed: \(error)")
            }
        } label: {
            settingsOptionRow(title: "Log Out", systemImage: "rectangle.portrait.and.arrow.right", color: .red, nav: nil)
        }
    }
    
    // MARK: - Contact Link Row
    @ViewBuilder
    func contactLinkRow() -> some View {
        if let url = URL(string: "mailto:akhusanbaev1@gmail.com") {
            Link(destination: url) {
                settingsOptionRow(title: "Contacts", systemImage: "person.2.fill", color: .green, nav: nil)
            }
        }
    }
    
    // MARK: - Settings Option Row
    @ViewBuilder
    func settingsOptionRow(title: String, systemImage: String, color: Color, nav: CustomNavigationOption?) -> some View {
        HStack {
            Image(systemName: systemImage)
                .resizable()
                .scaledToFit()
                .foregroundColor(color)
                .frame(width: 25, height: 25)
            
            Text(title)
                .padding(5)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .resizable()
                .scaledToFit()
                .foregroundColor(.accentColor)
                .frame(width: 20, height: 20)
        }
        .onTapGesture {
            if let destination = nav {
                customNavigation.path.append(destination)
            }
        }
        .padding(.vertical, 10)
        .frame(minHeight: 35)
    }
    
    // MARK: - User Name Label
    @ViewBuilder
    func userNameLabel(member: Member) -> some View {
        HStack(spacing: 30) {
            Image("profile")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            
            Text(member.name)
                .font(.system(size: 25, weight: .bold))
                .foregroundStyle(Color.primary)
            
            Spacer()
        }
    }
}
