//
//  CustomNavigationOption.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 21/09/24.
//

import SwiftUI

enum CustomNavigationOption: Hashable {
    case history(Member)
    case cabin(Cab)
    case article(Article)
    case sessionCreate(Cab)
    case sessionCheckout(AvailableHour)
    case privacyPolicy
    case termsOfService
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .history(let member): HistoryView(member: member)
        case .cabin(let cab): CabinView(cab: cab)
        case .article(let article): ArticleView(article: article)
        case .sessionCreate(let cab): SessionCreateView(cab: cab)
        case .sessionCheckout(let availableHour): SessionCheckoutView(availableHour: availableHour)
        case .privacyPolicy: Text("Privacy Policy")
        case .termsOfService: Text("Terms of Service")
        }
    }
}
