//
//  SessionCheckoutView.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 22/09/24.
//

import SwiftUI

struct SessionCheckoutView: View {
    @Environment(CustomNavigation.self) private var navigation
    let availableHour: AvailableHour
    @State private var sessionCheckoutObservable = SessionCheckoutObservable()
    @State private var displayQRCode: Bool = false
    
    var body: some View {
        @Bindable var sessionCheckoutObservable = sessionCheckoutObservable
        ZStack {
            Color.csBackground.ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Simulation Of Payment.")
                Text("\(availableHour.price)")
                Spacer()
                CC_PrimaryButton("PAY") {
                    Task {
                        do {
                            try await sessionCheckoutObservable.purchase()
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        }
        .task {
            await sessionCheckoutObservable.setAvailableHour(availableHour)
            do {
                try await sessionCheckoutObservable.getUser()
            } catch {
                print(error)
            }
        }
        .onChange(of: sessionCheckoutObservable.hasPurchasedItem) { oldValue, newValue in
            if newValue {
                displayQRCode = true
            }
        }
        .fullScreenCover(isPresented: $displayQRCode) {
            VStack {
                if let uiImage = sessionCheckoutObservable.generateQRCode(from: sessionCheckoutObservable.session?.id ?? "https://apple.com") {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                CC_PrimaryButton("OK") {
                    navigation.path.removeAll()
                }
            }
        }
    }
}
