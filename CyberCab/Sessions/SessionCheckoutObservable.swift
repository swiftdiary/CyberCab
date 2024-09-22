//
//  SessionCheckoutObservable.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 22/09/24.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins

@Observable
final class SessionCheckoutObservable {
    var availableHour: AvailableHour?
    var member: Member?
    var session: Session?
    
    var hasPurchasedItem: Bool = false
    
    @ObservationIgnored private let sessionManager = FirestoreManager<Session>()
    @ObservationIgnored private let authenticationService = AuthenticationService()
    @ObservationIgnored private let memberManager = FirestoreManager<Member>()
    
    @ObservationIgnored private let context = CIContext()
    @ObservationIgnored private let filter = CIFilter.qrCodeGenerator()
    
    func setAvailableHour(_ availableHour: AvailableHour) async {
        await MainActor.run {
            self.availableHour = availableHour
        }
    }
    
    func getUser() async throws {
        let authDataResult = try authenticationService.getAuthenticatedUser()
        let member = try await memberManager.getDocument(id: authDataResult.uid)
        await MainActor.run {
            self.member = member
        }
    }
    
    func purchase() async throws {
        guard let availableHour, let member else {
            return
        }
        // A real checkout will be implemented later...
        var newSession = Session(availableHourId: availableHour.id, memberId: member.id, scheduleDate: Date().addingTimeInterval(60*60*24), status: .scheduled)
        try await newSession.save()
        await MainActor.run {
            self.hasPurchasedItem = true
            self.session = newSession
        }
    }
    
    // Generate a high-quality QR Code from a string
    func generateQRCode(from string: String) -> UIImage? {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        
        if let outputImage = filter.outputImage?.transformed(by: transform) {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return nil
    }
}
