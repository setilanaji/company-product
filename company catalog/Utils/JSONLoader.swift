//
//  JSONLoader.swift
//  company catalog
//
//  Created by Yudha S on 06/07/23.
//

import Foundation

class JSONLoader {
    
    static func loadProductsFromJSON(fileName: String) -> [Product] {
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return []
        }

        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let products = try decoder.decode([Product].self, from: data)
            return products
        } catch {
            print("Error loading product data: \(error)")
            return []
        }
    }
}
