//
//  ProductRowView.swift
//  company catalog
//
//  Created by Yudha S on 05/07/23.
//

import SwiftUI

struct ProductRowView: View {
    @Binding var product: Product
    @StateObject private var imageLoader = ImageLoader()
    @EnvironmentObject var controller: ProductController
    
    var body: some View {
        VStack(spacing: 8) {
            
            ZStack(alignment: .topTrailing) {
                if let image = imageLoader.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 150)
                } else {
                    Color.gray
                        .frame(maxWidth: .infinity, maxHeight: 150)
                        .overlay(ProgressView())
                }
                
                Button(action: {
                    toggleFavorite()
                }) {
                    Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(product.isFavorite ? .blue : .gray)
                }
            }
            Text(product.name)
                .font(.headline)
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .onAppear {
            imageLoader.loadImage(from: product.imageURL)
        }
    }
    
    private func toggleFavorite() {
        controller.updateItem(product)
    }
}

struct ProductRowView_Previews: PreviewProvider {
    static var previews: some View {
        ProductRowView(product: .constant(item))
    }
    
    static let item = Product(
        id: "adfgdrgrf",
        name: "Ini",
        imageURL: "https://images.ctfassets.net/2d5q1td6cyxq/1eFfA2SW2rJlQgHAXSZWwD/0781a6aa69a90a822fd50b93fe107e8d/SHOP_Product_Reader_for_Magstripe_Headset_Jack_Gallery-01.png?h=996&w=2032")
}
