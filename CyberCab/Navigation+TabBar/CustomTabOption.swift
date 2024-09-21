//
//  CustomTabOption.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 21/09/24.
//

import SwiftUI

enum CustomTabOption: Hashable, CaseIterable {
    case home
    case saved
    case search
    case profile
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .home: HomeView().tag(self)
        case .saved: SavedView().tag(self)
        case .search: SearchView().tag(self)
        case .profile: ProfileView().tag(self)
        }
    }
    
    @ViewBuilder
    var label: some View {
        switch self {
        case .home:
            VStack {
                Image("home")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            .font(.caption)
        case .saved:
            VStack {
                Image("heart_outline")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            .font(.caption)
        case .search:
            VStack {
                Image("search")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            .font(.caption)
        case .profile:
            VStack {
                Image("user")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            .font(.caption)
        }
    }
    
    
}
