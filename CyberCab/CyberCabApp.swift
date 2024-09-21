//
//  CyberCabApp.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 21/09/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct CyberCabApp: App {
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true
    @AppStorage("isAuthenticated") private var isAuthenticated: Bool = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            Group {
                if isFirstLaunch {
                    OnboardingView()
                } else {
                    if isAuthenticated {
                        ContentView()
                    } else {
                        AuthenticationView()
                    }
                }
            }
            .preferredColorScheme(.light)
        }
    }
}
