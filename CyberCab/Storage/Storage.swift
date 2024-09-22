//
//  Storage.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 22/09/24.
//

import Foundation
import FirebaseStorage
import SwiftUI

final class StorageManager {
    private let storage = Storage.storage().reference()
    
    public func downloadPhoto(fileName: String) async throws -> UIImage {
        try await withCheckedThrowingContinuation { continuation in
            storage.child(fileName).getData(maxSize: 20*1024*1024) { result in
                switch result {
                case .success(let data):
                    if let uiImage = UIImage(data: data) {
                        continuation.resume(returning: uiImage)
                    } else {
                        continuation.resume(throwing: StorageManagerError.couldntConvertToUIImage)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

enum StorageManagerError: Error {
    case fileManagerCreationError(Error)
    case couldntConvertToJpeg
    case couldntConvertToUIImage
}
