//
//  HistoryView.swift
//  CyberCab
//
//  Created by Muhammadjon Madaminov on 21/09/24.
//

import SwiftUI

struct HistoryView: View {
    @Environment(CustomNavigation.self) var customNavigation
    @State var historyObservable = HistoryObservable()
    let member: Member?
    
    var body: some View {
        @Bindable var customNavigation = customNavigation
        @Bindable var historyObservable = historyObservable
        
        
        ZStack {
            Color.csBackground
                .ignoresSafeArea()
            
            VStack {
                ForEach(historyObservable.sessions) { session in
                    Text("\(session.id)")
                }
            }
        }
        .task {
            do {
                try await historyObservable.getSessions(member: member)
            } catch {
                print(error)
            }
        }
    }
}

//#Preview {
//    HistoryView()
//}
