//
//  company_catalogApp.swift
//  company catalog
//
//  Created by Yudha S on 05/07/23.
//

import SwiftUI

@main
struct company_catalogApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(controller: ProductController(
                repository: ProductRepository.shared
            ))
        }
    }
}
