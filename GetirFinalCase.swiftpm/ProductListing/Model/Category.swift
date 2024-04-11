//
//  File.swift
//  
//
//  Created by Berker Tomaç on 11.04.2024.
//

import Foundation
struct Category: Codable, Hashable {
    let id: String
    let name: String
    let products: [Product]
}
