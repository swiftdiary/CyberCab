//
//  CyberCabApp.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 21/09/24.
//

import SwiftUI

@main
struct CyberCabApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
            OnboardingView()
                .preferredColorScheme(.light)
        }
    }
}
