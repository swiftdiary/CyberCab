//
//  HomeView.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 21/09/24.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("isAuthenticated") private var isAuthenticated: Bool = false
    
    var body: some View {
        VStack {
            Text("Hello, World!")
        }
//        .onAppear {
//            try? AuthenticationService().logOut()
//            isAuthenticated = false
//        }
    }
}

#Preview {
    HomeView()
}
