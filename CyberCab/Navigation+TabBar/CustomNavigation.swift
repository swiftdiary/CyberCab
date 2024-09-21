//
//  CustomNavigation.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 21/09/24.
//

import Foundation

@Observable
final class CustomNavigation {
    var path = [CustomNavigationOption]()
    var tabSelection: CustomTabOption = .home
}
