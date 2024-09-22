//
//  HistoryView.swift
//  CyberCab
//
//  Created by Muhammadjon Madaminov on 21/09/24.
//

import SwiftUI



struct HistoryView: View {
    @State var historyObservable = HistoryObservable() // Assuming this exists and provides 'sessions'
    let member: Member?

    var body: some View {
        @Bindable var historyObservable = historyObservable
        
        List(historyObservable.sessions) { session in
            SessionRowView(session: session)
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



struct SessionRowView: View {
    let session: Session
    
    var body: some View {
        HStack(spacing: 16) {
            // Display the formatted schedule date
            VStack(alignment: .leading) {
                Text(formatDate(session.scheduleDate))
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(session.status.rawValue.capitalized)
                    .font(.subheadline)
                    .foregroundColor(session.status == .completed ? .green : .secondary)
            }
            
            Spacer()
            
            // Status Indicator
            if session.status == .completed {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            } else if session.status == .scheduled {
                Image(systemName: "clock.fill")
                    .foregroundColor(.blue)
            } else if session.status == .canceled {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
            }
        }
        .padding(.vertical, 8)
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy HH:mm"
        return dateFormatter.string(from: date)
    }
}

//#Preview {
//    HistoryView()
//}
