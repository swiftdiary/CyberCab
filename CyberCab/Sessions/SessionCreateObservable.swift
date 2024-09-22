//
//  SessionCreateObservable.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 22/09/24.
//

import Foundation

@Observable
final class SessionCreateObservable {
    var member: Member?
    var cab: Cab?
    var availableHours: [AvailableHour] = []
    
    var todayAvailable: [AvailableHour] = []
    var tomorrowAvailable: [AvailableHour] = []
    
    @ObservationIgnored private let authenticationService = AuthenticationService()
    @ObservationIgnored private let memberManager = FirestoreManager<Member>()
    @ObservationIgnored private let availableHourManager = FirestoreManager<AvailableHour>()
    
    @MainActor
    func getCab(cab: Cab) {
        self.cab = cab
    }
    
    func getUser() async throws {
        let authData = try authenticationService.getAuthenticatedUser()
        let member = try await memberManager.getDocument(id: authData.uid)
        await MainActor.run {
            self.member = member
        }
    }
    
    func getAvailableHours() async throws {
        guard let cab else { return }
        let availableHours = try await availableHourManager.getDocuments(queries: [.isEqualTo(field: "cabin_id", value: cab.id)])
        await MainActor.run {
            self.availableHours = availableHours
        }
        print("ALL AVAILABLE HOURS: ", availableHours, separator: "\n\n")
    }
    
    @MainActor
    func calculateFutureAvailableHours() {
        let (today, tomorrow) = filterAndSortAvailableHours(from: availableHours)
        todayAvailable = today
        tomorrowAvailable = tomorrow
    }
    
    
    // Helper function to get next available date for a given weekday and time
    func nextAvailableDate(for availableHour: AvailableHour) -> Date? {
        let calendar = Calendar.current
        let now = Date()
        
        // Break down the time string into components
        let timeComponents = availableHour.time.split(separator: ":").compactMap { Int($0) }
        guard timeComponents.count == 2 else { return nil }
        
        let hour = timeComponents[0]
        let minute = timeComponents[1]
        
        // Get the current weekday
        let currentWeekday = calendar.component(.weekday, from: now)
        
        // Find the next weekday that matches availableHour's weekday
        var daysToAdd = availableHour.weekday - currentWeekday
        if daysToAdd < 0 {
            daysToAdd += 7
        }
        
        // Calculate the next available date
        if let nextDate = calendar.date(byAdding: .day, value: daysToAdd, to: now) {
            let components = calendar.dateComponents([.year, .month, .day], from: nextDate)
            var dateWithTime = calendar.date(from: components)
            
            // Add the hour and minute to the calculated date
            dateWithTime = calendar.date(bySettingHour: hour, minute: minute, second: 0, of: dateWithTime!)
            
            // Check if the calculated time is in the past (today), if so, move to the next week
            if let dateWithTime = dateWithTime, dateWithTime < now {
                return calendar.date(byAdding: .day, value: 7, to: dateWithTime)
            }
            
            return dateWithTime
        }
        
        return nil
    }

    // Function to filter and sort AvailableHour instances for today and tomorrow
    func filterAndSortAvailableHours(from availableHours: [AvailableHour]) -> (today: [AvailableHour], tomorrow: [AvailableHour]) {
        let calendar = Calendar.current
        let now = Date()
        
        // Get the start and end of today
        let startOfToday = calendar.startOfDay(for: now)
        let startOfTomorrow = calendar.date(byAdding: .day, value: 1, to: startOfToday)!
        let startOfDayAfterTomorrow = calendar.date(byAdding: .day, value: 2, to: startOfToday)!
        
        var todayHours: [(AvailableHour, Date)] = []
        var tomorrowHours: [(AvailableHour, Date)] = []
        
        for availableHour in availableHours {
            if let nextAvailable = nextAvailableDate(for: availableHour) {
                if nextAvailable >= startOfToday && nextAvailable < startOfTomorrow {
                    todayHours.append((availableHour, nextAvailable))
                } else if nextAvailable >= startOfTomorrow && nextAvailable < startOfDayAfterTomorrow {
                    tomorrowHours.append((availableHour, nextAvailable))
                }
            }
        }
        
        // Sort by the next available date (second element in the tuple)
        todayHours.sort { $0.1 < $1.1 }
        tomorrowHours.sort { $0.1 < $1.1 }
        
        // Return only the AvailableHour, sorted
        return (todayHours.map { $0.0 }, tomorrowHours.map { $0.0 })
    }
}
