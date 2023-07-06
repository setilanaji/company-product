//
//  ContentView.swift
//  company catalog
//
//  Created by Yudha S on 05/07/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var controller: ProductController
    @State private var searchText: String = ""
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(controller.filteredProduct) { product in
                        ProductRowView(product: .constant(product))
                            .aspectRatio(3/2, contentMode: .fit)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding()
                .environmentObject(controller)
            }
            .background(Color.gray.opacity(0.05))
            .navigationTitle("Product")
            .onAppear {
                controller.fetchProducts()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Toggle(isOn: $controller.showFavoriteOnly, label: {
                            Text("Favorites Only")
                        })
                    } label: {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                    }
                }
                
            }
        }
        .searchable(text: $searchText)
        .onAppear(perform: runSearch)
        .onSubmit(of: .search, runSearch)
        .onChange(of: searchText) { _ in
            runSearch()
        }
    }
    
    private func runSearch() {
        controller.key = searchText
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(controller: ProductController(
            repository: ProductRepository.shared
        ))
    }
}
