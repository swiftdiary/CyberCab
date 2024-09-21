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
    
    var body: some View {
        @Bindable var profileObservable = profileObservable
        @Bindable var customNavigation = customNavigation
        
        ZStack {
            Color.csBackground
                .ignoresSafeArea()
            
            if let member = profileObservable.member {
                VStack(spacing: 20) {
                    UserNameLabel(member: member)
                        .padding(.leading)
                    
                    SettingsOptions(member: member)
                        
                    Spacer()
                }
                .padding(.top, 10)
            } else {
                ProgressView()
            }
        }
//        .environment(profileObservable)
        .environment(customNavigation)
        .task {
            do {
                try await profileObservable.getMember()
            } catch {
                print(error)
            }
        }
    }
    
    // Updated SettingsOptions with SF Symbols and accent colors
    @ViewBuilder private func SettingsOptions(member: Member) -> some View {
        VStack {
            List {
                SettingsOptionRow(title: "History", systemImage: "clock.fill", color: .blue, nav: .history(memvber: member))
                if let url = URL(string: "mailto:akhusanbaev1@gmail.com") {
                    Link(destination: url) {
                        SettingsOptionRow(title: "Contacts", systemImage: "person.2.fill", color: .green, nav: nil)
                    }
                }
                SettingsOptionRow(title: "Privacy Policy", systemImage: "lock.shield.fill", color: .purple, nav: .privacyPolicy)
                SettingsOptionRow(title: "Terms of Use", systemImage: "doc.text.fill", color: .orange, nav: .termsOfService)
            }
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .font(.system(size: 22, weight: .medium))
            .foregroundStyle(Color.primary)
        }
    }

    // A reusable row component for settings options with an SF Symbol
    @ViewBuilder private func SettingsOptionRow(title: String, systemImage: String, color: Color, nav: CustomNavigationOption?) -> some View {
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
            if let nav1 = nav {
                customNavigation.path.append(nav1)
            }
        }
        .padding(.vertical, 10)
        .frame(minHeight: 35)
    }
    
    @ViewBuilder private func UserNameLabel(member: Member) -> some View {
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

