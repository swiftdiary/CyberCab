//
//  CustomNavigationOption.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 21/09/24.
//

import SwiftUI

enum CustomNavigationOption: Hashable {
    case settings
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .settings: Text("Settings page....")
        }
    }
}
