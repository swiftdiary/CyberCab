//
//  ArticleObservable.swift
//  CyberCab
//
//  Created by Muhammadjon Madaminov on 22/09/24.
//

import Foundation
import SwiftUI


@Observable
final class ArticleObservable {
    var images: [String:UIImage] = [:]
    
    @ObservationIgnored private let storageManager = StorageManager()
    
    func getAllImages(article: Article) async throws {
        images = [:]
        images[article.image] = try await storageManager.downloadPhoto(fileName: article.image)
        
        for content in article.content {
            if content.type.rawValue == "image" {
                images[content.image ?? ""] = try await storageManager.downloadPhoto(fileName: content.image ?? "")
            }
        }
    }
}
