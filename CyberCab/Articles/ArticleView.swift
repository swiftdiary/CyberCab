//
//  ArticlesView.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 22/09/24.
//

import SwiftUI

struct ArticleView: View {
    @State private var articleObservable = ArticleObservable()
    let article: Article
    
    var body: some View {
        ZStack {
            Color.csBackground
                .ignoresSafeArea()
            
            
            ScrollView {
                VStack {
                    ArticleHeaderView()
                        .ignoresSafeArea()
                    
                    ForEach(article.content, id: \.self) { content in
                        ArticleContentView(content: content)
                    }
                }
            }
            .task {
                do {
                    try await articleObservable.getAllImages(article: article)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    
    
    @ViewBuilder private func ArticleHeaderView() -> some View {
        VStack {
            if let image = articleObservable.images[article.image] {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .frame(height: 300)
                    .overlay(alignment: .bottom) {
                        HStack {
                            CC_Text(article.title.localized)
                                .font(.title2)
                                .bold()
                            
                            Spacer()
                        }
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                        .offset(y: 50)
                    }
            }
        }
    }
    
    
    @ViewBuilder private func ArticleContentView(content: ArticleContent) -> some View {
        VStack {
            switch content.type {
                case .paragraph:
                CC_Text(content.paragraph?.localized ?? "")
                    .font(.body)
                    .lineLimit(nil)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                    .frame(maxWidth: .infinity)
            case .headline:
                CC_Text(content.headline?.localized ?? "")
                    .font(.headline)
                    .lineLimit(nil)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                    .frame(maxWidth: .infinity)
            case .image:
                if let uimage = articleObservable.images[content.image ?? ""] {
                    Image(uiImage: uimage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                }
            case .arItem:
                Text("null")
            }
        }
    }
}
