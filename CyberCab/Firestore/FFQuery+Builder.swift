//
//  FFQuery+Builder.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 21/09/24.
//

import Foundation
import FirebaseFirestore

enum FFQuery {
    case isEqualTo(field: String, value: Any)
    case isGreaterThan(field: String, value: Any)
    case isLessThan(field: String, value: Any)
    case arrayContains(field: String, value: Any)
    case limit(to: Int)
    case orderBy(field: String, descending: Bool)
}

struct FFQueryBuilder {
    var queries: [FFQuery]

    func buildQuery(for collection: CollectionReference) -> Query {
        var query: Query = collection

        for ffQuery in queries {
            switch ffQuery {
            case .isEqualTo(let field, let value):
                query = query.whereField(field, isEqualTo: value)
            case .isGreaterThan(let field, let value):
                query = query.whereField(field, isGreaterThan: value)
            case .isLessThan(let field, let value):
                query = query.whereField(field, isLessThan: value)
            case .arrayContains(let field, let value):
                query = query.whereField(field, arrayContains: value)
            case .limit(let value):
                query = query.limit(to: value)
            case .orderBy(let field, let descending):
                query = query.order(by: field, descending: descending)
            }
        }
        
        return query
    }
}
