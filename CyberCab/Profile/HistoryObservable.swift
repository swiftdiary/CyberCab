//
//  HistoryObservable.swift
//  CyberCab
//
//  Created by Muhammadjon Madaminov on 22/09/24.
//

import Foundation
import CoreImage.CIFilterBuiltins
import SwiftUI


@Observable
final class HistoryObservable {
    var sessions: [Session] = []
    var qrImage: UIImage? = nil
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    let sessionsManager = FirestoreManager<Session>()
    let availableHoursManager = FirestoreManager<AvailableHour>()
    let cabManager = FirestoreManager<Cab>()
    
    func getSessions(member: Member?) async throws {
        guard let member else { return }
        let sessions = try await sessionsManager.getDocuments(queries: [.isEqualTo(field: "memberId", value: member.id)])
        
        await MainActor.run {
            self.sessions = sessions
        }
    }
    
    func generateQRCode(from string: String) {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        
        if let outputImage = filter.outputImage?.transformed(by: transform) {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                qrImage = UIImage(cgImage: cgimg)
            }
        }
    }
    
}
