//
//  Article.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 22/09/24.
//

import Foundation

struct Article: Firestorable {
    let id: String
    var createdAt: Date
    static let collectionReferenceName: String = "articles"
    
    let title: AppLocalizable
    let content: [ArticleContent]
    let image: String
}

struct ArticleContent: Codable, Hashable {
    let type: ArticleContentType
    let headline: AppLocalizable?
    let paragraph: AppLocalizable?
    let image: String?
    let arItem: String?
    
    enum ArticleContentType: String, Codable {
        case headline
        case paragraph
        case image
        case arItem
    }
}
