//
//  HomeObservable.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 22/09/24.
//

import Foundation
import SwiftUI

@Observable
final class HomeObservable {
    var member: Member?
    
    var articles: [Article] = []
    var articleImages: [String : UIImage] = [:]
    var cabs: [Cab] = []
    var cabImages: [String : UIImage] = [:]
    
    @ObservationIgnored private let authenticationService = AuthenticationService()
    @ObservationIgnored private let articleManager = FirestoreManager<Article>()
    @ObservationIgnored private let cabManager = FirestoreManager<Cab>()
    @ObservationIgnored private let memberManager = FirestoreManager<Member>()
    @ObservationIgnored private let storageManager = StorageManager()
    
    func getUser() async throws {
        let authData = try authenticationService.getAuthenticatedUser()
        guard let member = try await memberManager.getDocument(id: authData.uid) else { throw HomeObservableError.noMember }
        await MainActor.run {
            self.member = member
        }
    }
    
    func getArticles() async throws {
        let articles = try await articleManager.getDocuments(queries: [.orderBy(field: "createdAt", descending: true)])
        await MainActor.run {
            self.articles = articles
        }
    }
    
    func getArticleImages() async throws {
        for article in articles {
            let uiImage = try await storageManager.downloadPhoto(fileName: article.image)
            await MainActor.run {
                articleImages[article.id] = uiImage
            }
        }
    }
    
    func getCabs() async throws {
        let cabs = try await cabManager.getDocuments(queries: [.orderBy(field: "createdAt", descending: true)])
        await MainActor.run {
            self.cabs = cabs
        }
    }
    
    func getCabImages() async throws {
        for cab in cabs {
            let uiImage = try await storageManager.downloadPhoto(fileName: cab.image)
            await MainActor.run {
                cabImages[cab.id] = uiImage
            }
        }
    }
    
    
}

enum HomeObservableError: Error {
    case noMember
}
