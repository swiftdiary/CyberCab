//
//  HomeView.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 21/09/24.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("isAuthenticated") private var isAuthenticated: Bool = false
    @State private var homeObservable = HomeObservable()
    
    var body: some View {
        @Bindable var homeObservable = homeObservable
        ZStack {
            Color.csBackground.ignoresSafeArea()
            
            VStack {
                ScrollView {
                    TopToolbar()
                    ArticlesSection()
                    RecommendedSection()
                    OtherCabs()
                }
            }
        }
        .task(priority: .userInitiated) {
            do {
                try await homeObservable.getUser()
            } catch {
                print(error)
            }
        }
        .task(priority: .high) {
            do {
                try await homeObservable.getArticles()
                try await homeObservable.getArticleImages()
            } catch {
                print(error)
            }
        }
        .task(priority: .high) {
            do {
                try await homeObservable.getCabs()
                try await homeObservable.getCabImages()
            } catch {
                print(error)
            }
        }
    }
    
    @ViewBuilder
    private func TopToolbar() -> some View {
        HStack {
            CC_Text("EXPLORE.", size: 26)
                .fontWeight(.semibold)
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "ellipsis")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            .foregroundStyle(.accent)

        }
        .padding()
    }
    
    @ViewBuilder
    private func ArticlesSection() -> some View {
        VStack {
            CC_Text("Articles")
                .fontWeight(.semibold)
                .padding()
            ScrollView(.horizontal) {
                HStack {
                    ForEach(homeObservable.articles) { article in
                        ArticleItem(article: article)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private func ArticleItem(article: Article) -> some View {
        VStack(alignment: .leading) {
            if let uiImage = homeObservable.articleImages[article.id] {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 12.0))
            }
            CC_Text(article.title.localized)
                .fontWeight(.semibold)
                .lineLimit(2)
                .padding()
        }
        .frame(width: 154)
        .padding(10)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
        }
        .padding(.horizontal, 10)
    }
    
    @ViewBuilder
    private func RecommendedSection() -> some View {
        VStack {
            CC_Text("RECOMMENDED FOR YOU.", size: 18)
                .fontWeight(.semibold)
                .padding()
            VStack {
                ForEach(homeObservable.cabs.prefix(2)) { cab in
                    CabRowItem(cab: cab)
                }
            }
        }
    }
    
    @ViewBuilder
    private func CabRowItem(cab: Cab) -> some View {
        HStack {
            if let uiImage = homeObservable.cabImages[cab.id] {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12.0)
                    )
            }
            CC_Text(cab.name.localized)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
        .background {
            RoundedRectangle(cornerRadius: 12.0)
                .fill(Color.white)
        }
        .padding(.horizontal, 10)
    }
    
    @ViewBuilder
    private func OtherCabs() -> some View {
        VStack {
            CC_Text("EXPLORE MORE.", size: 18)
                .fontWeight(.semibold)
                .padding()
            VStack {
                ForEach(homeObservable.cabs) { cab in
                    CabRowItem(cab: cab)
                }
            }
        }
    }
}
