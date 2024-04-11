//
//  File.swift
//  
//
//  Created by Berker Tomaç on 11.04.2024.
//

import Foundation
struct Product: Codable, Hashable {
    let id: String
    let name: String
    let attribute: String?
    let thumbnailURL: String?
    let imageURL: String
    let price: Double
    let priceText: String
    let shortDescription: String?
    
    // Provide a unique hash by combining the product's id and name
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
    
    // Implement equatable to compare if two products are the same
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}
