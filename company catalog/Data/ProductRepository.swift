//
//  ProductRepository.swift
//  company catalog
//
//  Created by Yudha S on 06/07/23.
//

import Foundation

protocol ProductRepositoryProtocol {
    func getProducts() -> [Product]
    func toggleFavorite(for product: Product)
}

class ProductRepository: ProductRepositoryProtocol {
    static let shared = ProductRepository()
    
    private let favoritesKey = "favoriteProducts"
    
    func getProducts() -> [Product] {
        var products = JSONLoader.loadProductsFromJSON(fileName: "products")
        let favoriteProducts = getFavoriteProducts()
        stride(from: 0, to: products.count, by: 1).forEach { index in
            if favoriteProducts.first(where: { $0.id == products[index].id }) != nil {
                products[index].isFavorite = true
            } else {
                products[index].isFavorite = false
            }
        }
        return products
    }
    
    private func getFavoriteProducts() -> [Product] {
        let favoriteProductsData = UserDefaults.standard.data(forKey: favoritesKey)
        let decoder = JSONDecoder()
        
        guard let favoriteProducts = favoriteProductsData, let products = try? decoder.decode([Product].self, from: favoriteProducts) else {
            return []
        }
        
        return products
    }
    
    func toggleFavorite(for product: Product) {
        var products = getProducts()
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products[index].isFavorite.toggle()
        }
        saveProducts(products.filter(\.isFavorite))
    }
    
    private func saveProducts(_ products: [Product]) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(products) {
            UserDefaults.standard.set(encodedData, forKey: favoritesKey)
        }
    }
}
