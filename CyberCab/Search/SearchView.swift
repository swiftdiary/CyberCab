//
//  SearchView.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 21/09/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchObservable = SearchObservable()
    
    var body: some View {
        @Bindable var searchObservable = searchObservable
        
        ZStack {
            
            Color.csBackground
                .ignoresSafeArea()
            
            VStack {
                TextField("Search...", text: $searchObservable.searchText)
                    .padding()
                    .padding(.leading, 30)
                    .overlay(alignment: .leading) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color.primary)
                            .padding(.leading)
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding()
                
                ScrollView {
                    
                }
            }
            .padding()
        }
        .task {
            do {
                try await searchObservable.getCabs()
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    SearchView()
}
