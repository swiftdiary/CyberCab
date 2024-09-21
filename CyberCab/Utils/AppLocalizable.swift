//
//  AppLocalizable.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 21/09/24.
//

import Foundation

struct AppLocalizable: Codable, Hashable {
    let en: String
    let ru: String
    let uz: String
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.en = try container.decode(String.self, forKey: .en)
        self.ru = try container.decode(String.self, forKey: .ru)
        self.uz = try container.decode(String.self, forKey: .uz)
    }
    
    enum CodingKeys: String, CodingKey {
        case en
        case ru
        case uz
    }
    
    var localized: String {
        if let preferredLanguage = Locale.preferredLanguages.first {
            if preferredLanguage.starts(with: "ru") {
                return ru
            } else if preferredLanguage.starts(with: "uz") {
                return uz
            } else {
                return en
            }
        } else {
            return en
        }
    }
}
