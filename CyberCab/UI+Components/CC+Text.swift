//
//  CC+Text.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 22/09/24.
//

import SwiftUI

struct CC_Text: View {
    let text: LocalizedStringKey
    let size: CGFloat?
    
    init(_ text: LocalizedStringKey, size: CGFloat? = nil) {
        self.text = text
        self.size = size
    }
    
    init(_ text: String, size: CGFloat? = nil) {
        self.text = LocalizedStringKey(text)
        self.size = size
    }
    
    var body: some View {
        Text(text)
            .font(.custom("Gothic A1", size: size ?? 16))
    }
}

#Preview {
    CC_Text("Hello", size: 24)
        .bold()
}
