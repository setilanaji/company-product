//
//  ImageLoader.swift
//  company catalog
//
//  Created by Yudha S on 05/07/23.
//

import Combine
import UIKit

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellables = Set<AnyCancellable>()
    
    func loadImage(from url: String) {
        guard let imageURL = URL(string: url) else {
            
            return
        }
        
        URLSession.shared
            .dataTaskPublisher(for: imageURL)
            .map { data, _ in UIImage(data: data)}
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
            .store(in: &cancellables)
    }
}
