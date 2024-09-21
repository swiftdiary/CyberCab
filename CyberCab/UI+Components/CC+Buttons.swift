//
//  CC+Buttons.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 22/09/24.
//

import SwiftUI

struct CC_PrimaryButton: View {
    let title: LocalizedStringKey
    let size: CGFloat?
    let action: () -> Void
    
    init(_ title: LocalizedStringKey, size: CGFloat? = nil, action: @escaping () -> Void) {
        self.title = title
        self.size = size
        self.action = action
    }
    
    var body: some View {
        Button(title, action: action)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .font(.custom("Gothic A1", size: size ?? 20))
            .fontWeight(.bold)
            .foregroundStyle(.background)
            .background {
                RoundedRectangle(cornerRadius: 50)
                    .fill(Gradient(colors: [.csSecondary, .accent]))
            }
    }
}

struct CC_Button: View {
    let title: LocalizedStringKey
    let size: CGFloat?
    let action: () -> Void
    
    init(_ title: LocalizedStringKey, size: CGFloat? = nil, action: @escaping () -> Void) {
        self.title = title
        self.size = size
        self.action = action
    }
    
    var body: some View {
        Button(title, action: action)
            .font(.custom("Gothic A1", size: size ?? 16))
            .fontWeight(.semibold)
            .foregroundStyle(.background)
            .padding(10)
            .padding(.horizontal, 25)
            .background {
                RoundedRectangle(cornerRadius: 50)
                    .fill(Gradient(colors: [.csSecondary, .accent]))
            }
    }
}
