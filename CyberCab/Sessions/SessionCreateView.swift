//
//  SessionCreateView.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 22/09/24.
//

import SwiftUI

// This is booking 
struct SessionCreateView: View {
    let cab: Cab
    
    @State private var sessionCreateObservable = SessionCreateObservable()
    
    var body: some View {
        ZStack {
            Color.csBackground.ignoresSafeArea()
            
            VStack {
                TopToolbar()
                ScrollView {
                    CC_Text("TODAY AVAILABLE", size: 26)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fontWeight(.semibold)
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(sessionCreateObservable.todayAvailable) { available in
                            NavigationLink(value: CustomNavigationOption.sessionCheckout(available)) {
                                VStack {
                                    Text("\(available.time)")
                                    Text("\(available.price)")
                                }
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background {
                                    RoundedRectangle(cornerRadius: 10.0)
                                        .fill(Color.white)
                                }
                                .padding(5)
                            }
                            .foregroundStyle(.black)
                        }
                    }
                    CC_Text("TOMORROW", size: 26)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fontWeight(.semibold)
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(sessionCreateObservable.tomorrowAvailable) { available in
                            NavigationLink(value: CustomNavigationOption.sessionCheckout(available)) {
                                VStack {
                                    Text("\(available.time)")
                                    Text("\(available.price)")
                                }
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background {
                                    RoundedRectangle(cornerRadius: 10.0)
                                        .fill(Color.white)
                                }
                                .padding(5)
                            }
                            .foregroundStyle(.black)
                        }
                    }
                }
                
            }
            .padding()
        }
        .task(priority: .userInitiated) {
            sessionCreateObservable.getCab(cab: cab)
            do {
                try await sessionCreateObservable.getUser()
            } catch {
                print(error)
            }
        }
        .task(priority: .high) {
            do {
                try await sessionCreateObservable.getAvailableHours()
                sessionCreateObservable.calculateFutureAvailableHours()
            } catch {
                print(error)
            }
        }
    }
    
    @ViewBuilder
    private func TopToolbar() -> some View {
        HStack {
            CC_Text("BOOK A SESSION.", size: 32)
                .fontWeight(.bold)
            Spacer()

        }
        .padding()
    }
}
