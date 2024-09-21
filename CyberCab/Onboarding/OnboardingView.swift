//
//  OnboardingView.swift
//  CyberCab
//
//  Created by Muhammadjon Madaminov on 21/09/24.
//
import SwiftUI

struct OnboardingView: View {
    @State private var scrollOffset: CGFloat = -50  // Initial scroll offset
    @State private var pageNum = 0  // Tracks the current page number
    @State private var gradientPercent: CGFloat = 0.6
    
    let images1: [String] = ["cardriver", "container", "policeman", "programmer","pilot"]
    let images2: [String] = ["policeman","constructor", "doctor", "pilot", "cardriver"]
    
    // Body of the View
    var body: some View {
        ZStack {
            // Background color
            Color.csBackground
                .ignoresSafeArea()
            
            VStack {
                // Images View with horizontal scrolling
                ImagesView()
                    .padding(.top, 70)
                
                // Title text
                Text("Try & Find your dream job")
                    .font(.system(size: 36, weight: .bold))
                    .fontDesign(.monospaced)
                    .padding(.horizontal, 20)
                    .padding(.vertical)
                    .background(LinearGradient(stops: [.init(color: .gray.opacity(0.5), location: 0), .init(color: .csBackground, location: gradientPercent)], startPoint: .leading, endPoint: .trailing))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .frame(maxHeight: .infinity)
                    .padding(.horizontal)
                
                // Next button
                NextButton()
                    .padding(20)
            }
        }
    }
    
    // ImagesView: A combined view for displaying two sets of images
    @ViewBuilder private func ImagesView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack(spacing: 20) {
                // First row of images
                ImagesHstackView(images: images1)
                
                // Second row of images, with leading padding
                ImagesHstackView(images: images2)
                    .padding(.leading, -170)
            }
            // Applying the offset for scrolling effect
            .offset(x: scrollOffset)
        }
    }
    
    // ImagesHstackView: A reusable horizontal stack of images
    @ViewBuilder private func ImagesHstackView(images: [String]) -> some View {
        HStack {
            ForEach(images, id: \.self) { image in
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 10)
            }
        }
    }
    
    // NextButton: Handles the scrolling and page navigation
    @ViewBuilder private func NextButton() -> some View {
        HStack {
            Spacer()  // Aligns the button to the right
            
            Button(action: handleNextButtonTap) {
                HStack {
                    Text("Next")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(20)
                    
                    Image(systemName: "arrow.forward")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 40)
                .background(Gradient(colors: [.csSecondary, .accent]))
                .clipShape(RoundedRectangle(cornerRadius: 50))
            }
            .buttonStyle(.plain)
        }
    }
    
    // Function to handle the next button tap action
    private func handleNextButtonTap() {
        withAnimation(.spring) {
            // Check if we can scroll further (based on pageNum)
            if pageNum < 2 {
                // Move the scroll offset by 2/3 of the screen width
                scrollOffset -= UIScreen.main.bounds.width / 3 * 2
                pageNum += 1
                gradientPercent += 0.2
            } else {
                // Perform any action when you reach the last page
                // Example: Proceed to the next screen or finish onboarding
                print("Reached the end of onboarding!")
            }
        }
    }
}

#Preview {
    OnboardingView()
}
