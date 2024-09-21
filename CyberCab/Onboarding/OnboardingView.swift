//
//  OnboardingView.swift
//  CyberCab
//
//  Created by Muhammadjon Madaminov on 21/09/24.
//

import SwiftUI

struct OnboardingView: View {
    let images1: [String] = ["cardriver", "container", "policeman", "programmer"]
    let images2: [String] = ["constructor", "doctor", "pilot", "cardriver"]
    
    
    var body: some View {
        ZStack {
            
            Color.csBackground
                .ignoresSafeArea()
            
            VStack {
                ImagesView()
                    .padding(.top, 70)
                
                Text("Try & Find your dream job")
                    .font(.system(size: 40, weight: .medium))
                    .padding(.horizontal, 20)
            }
        }
    }
    
    
    @ViewBuilder private func ImagesView() -> some View {
        VStack(spacing: 20) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(images1, id: \.self) { image in
                        Image(image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.horizontal, 10)
                    }
                }
                .padding(.leading, 100)
            }
            .scrollDisabled(true)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(images2, id: \.self) { image in
                        Image(image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.horizontal, 10)
                    }
                }
            }
            .scrollDisabled(true)
        }
    }
}

#Preview {
    OnboardingView()
}
