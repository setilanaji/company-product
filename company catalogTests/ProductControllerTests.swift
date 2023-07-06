//
//  ProductControllerTests.swift
//  company catalogTests
//
//  Created by Yudha S on 06/07/23.
//

import XCTest

final class ProductControllerTests: XCTestCase {
    
    var controller: ProductController!
    var mockRepository: MockProductRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockProductRepository()
        controller = ProductController(repository: mockRepository)
    }
    
    override func tearDown() {
        controller = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testFetchProducts() {
        let mockProducts = [Product(id: "koko", name: "Product 1", imageURL: ""), Product(id: "kiki", name: "Product 2", imageURL: "")]
        mockRepository.products = mockProducts
        let expectation = XCTestExpectation(description: "Fetch products")
        
        controller.fetchProducts()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.controller.filteredProduct, mockProducts)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testUpdateItem() {
        var product = Product(id: "koko", name: "Product 1", imageURL: "")
        mockRepository.toggleFavoriteHandler = { _ in
            product.isFavorite.toggle()
        }
        
        controller.updateItem(product)
        
        XCTAssertEqual(product.isFavorite, true)
        XCTAssertEqual(controller.filteredProduct.count, 0)
    }
}

class MockProductRepository: ProductRepositoryProtocol {
    var products = [Product]()
    var toggleFavoriteHandler: ((Product) -> Void)?
    
    func getProducts() -> [Product] {
        return products
    }
    
    func toggleFavorite(for product: Product) {
        toggleFavoriteHandler?(product)
    }
}
