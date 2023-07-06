//
//  ProductController.swift
//  company catalog
//
//  Created by Yudha S on 05/07/23.
//

import Foundation
import Combine

class ProductController: ObservableObject {
    @Published private var products = [Product]()
    @Published var filteredProduct = [Product]()
    @Published var showFavoriteOnly = false
    
    var key: String = "" {
        didSet {
            searchKey.send(key)
        }
    }
    
    private var searchKey = PassthroughSubject<String, Never>()
    private var cancellables = Set<AnyCancellable>()
    private let repository: ProductRepositoryProtocol
    
    init(
        repository: ProductRepositoryProtocol
    ) {
        self.repository = repository
        $products
            .sink { value in
                self.searchProduct(for: self.key, products: value, showFavoriteOnly: self.showFavoriteOnly)
            }
            .store(in: &cancellables)
        
        searchKey.sink { value in
            self.searchProduct(for: value, products: self.products, showFavoriteOnly: self.showFavoriteOnly)
        }
        .store(in: &cancellables)
        
        $showFavoriteOnly
            .sink { value in
                self.searchProduct(for: self.key, products: self.products, showFavoriteOnly: value)
            }.store(in: &cancellables)
    }
    
    func fetchProducts() {
        DispatchQueue.main.async {
            self.products = self.repository.getProducts()
        }
    }
    
    private func searchProduct(for key: String, products: [Product], showFavoriteOnly: Bool) {
        let filteredProducts = showFavoriteOnly ? products.filter(\.isFavorite) : products
        self.filteredProduct = key.isEmpty ? filteredProducts : filteredProducts.filter { $0.name.lowercased().contains(key.lowercased())}
    }
    
    func updateItem(_ product: Product) {
        self.repository.toggleFavorite(for: product)
        fetchProducts()
    }
}
