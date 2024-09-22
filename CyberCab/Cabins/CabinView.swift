//
//  CabinsView.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 22/09/24.
//

import SwiftUI

struct CabinView: View {
    @Environment(CustomNavigation.self) private var navigation
    @State private var cabinObservable = CabinObservable()
    let cab: Cab
    
    var body: some View {
        @Bindable var cabinObservable = cabinObservable
        
        ZStack {
            Color.csBackground
            
            
            VStack {
                ScrollView {
                    CabinHeaderView()
                    
                    
                    NameLabel()
                        .padding(5)
                    
                    ForEach(cab.content, id: \.self) { content in
                        DescriptionLabel(content: content)
                    }
                }
                CC_PrimaryButton("BOOK A TOUR") {
                    
                }
            }
        }
        .task {
            do {
                try await cabinObservable.getAllImages(cab: cab)
            } catch {
                print(error)
            }
        }
    }
    
    
    @ViewBuilder private func CabinHeaderView() -> some View {
        VStack {
            if let image = cabinObservable.images[cab.image] {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .frame(height: 300)
                    .overlay(alignment: .topLeading) {
                        VStack {
                            CC_Text(cab.name.localized)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(Color.white)
                            
                            CC_Text(cab.profession.localized)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.white)
                        }
                        .padding()
                        .background(Color.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                    }
            }
        }
    }
    
    
    @ViewBuilder private func NameLabel() -> some View {
        HStack {
            CC_Text(cab.name.localized)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color.black)
            
            Spacer()
            
            Image(systemName: "heart")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
        }
        .padding(.horizontal, 20)
    }
    
    
    @ViewBuilder private func DescriptionLabel(content: CabContent) -> some View {
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
            case .heading:
                CC_Text(content.heading?.localized ?? "")
                    .font(.headline)
                    .lineLimit(nil)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                    .frame(maxWidth: .infinity)
            case .image:
                if let uimage = cabinObservable.images[content.image ?? ""] {
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
