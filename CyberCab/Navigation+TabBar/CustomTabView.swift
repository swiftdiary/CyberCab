//
//  CustomTabView.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 21/09/24.
//

import SwiftUI

struct CustomTabView: View {
    @State private var customNavigation = CustomNavigation()
    @State private var tabIsVisible: Bool = true
    @Namespace private var namespace
    
    var body: some View {
        @Bindable var customNavigation = customNavigation
        ZStack(alignment: .bottom) {
            TabView(selection: $customNavigation.tabSelection, content: {
                ForEach(CustomTabOption.allCases, id: \.hashValue) { option in
                    NavigationStack(path: $customNavigation.path) {
                        option.view
                            .environment(customNavigation)
                            .toolbar(.hidden)
                            .navigationDestination(for: CustomNavigationOption.self, destination: { $0.destination.toolbar(.hidden, for: .tabBar).environment(customNavigation) })
                    }
                    .tag(option)
                }
            })
            if customNavigation.path.isEmpty {
                HStack {
                    ForEach(CustomTabOption.allCases, id: \.hashValue) { option in
                        HStack {
                            VStack {
                                Button(action: {
                                    withAnimation(.bouncy) {
                                        customNavigation.tabSelection = option
                                    }
                                }, label: {
                                    option.label
                                })
                                .foregroundStyle(.black)
                                if customNavigation.tabSelection == option {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.accentColor)
                                        .frame(width: 15, height: 2)
                                        .matchedGeometryEffect(id: "TabBar", in: namespace)
                                } else {
                                    HStack{}.frame(height: 2)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 30.0)
                        .fill(.background)
                        .shadow(radius: 10)
                )
                .padding(.horizontal)
            }
        }
    }
}
