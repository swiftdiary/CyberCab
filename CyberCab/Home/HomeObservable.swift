//
//  HomeObservable.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 22/09/24.
//

import Foundation

@Observable
final class HomeObservable {
    var articles: [Article] = []
    var cabs: [Cab] = []
    var locations: [Location] = []
    
}
