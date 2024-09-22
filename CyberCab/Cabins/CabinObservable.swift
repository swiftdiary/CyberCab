//
//  CabinObservable.swift
//  CyberCab
//
//  Created by Muhammadjon Madaminov on 22/09/24.
//

import Foundation
import SwiftUI


@Observable
final class CabinObservable {
    var images: [String:UIImage] = [:]
    
    @ObservationIgnored private let storageManager = StorageManager()
    
    
    func getAllImages(cab: Cab) async throws {
        images = [:]
        images[cab.image] = try await storageManager.downloadPhoto(fileName: cab.image)
        
        for content in cab.content {
            if let image = content.image {
                images[image]  = try await storageManager.downloadPhoto(fileName: image)
            }
        }
    }
}
