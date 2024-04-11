//
//  File.swift
//  
//
//  Created by Berker Tomaç on 11.04.2024.
//

import Foundation
struct SuggestedProduct: Codable, Hashable {
    let id: String
    let imageURL: String
    let price: Double
    let name: String
    let priceText: String
    let shortDescription: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: SuggestedProduct, rhs: SuggestedProduct) -> Bool {
        return lhs.id == rhs.id
    }
}
