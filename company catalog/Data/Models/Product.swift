//
//  Product.swift
//  company catalog
//
//  Created by Yudha S on 05/07/23.
//

import Foundation

struct Product: Identifiable, Codable, Equatable {
    let id: String
    let name: String
    let imageURL: String
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case imageURL = "picture"
        case isFavorite
    }
}
