//
//  ImageLoader.swift
//  FetchRecipes
//
//  Created by pgAgent on 5/28/25.
//

import Foundation
import UIKit

func loadImageFromURL(from url: URL) async throws -> UIImage {
    let (data, _) = try await URLSession.shared.data(from: url)
    guard let image = UIImage (data: data) else  {
        throw URLError(.badServerResponse)
    }
    return image
}

func loadImageFromCache(from url: URL) async throws -> UIImage {
    let key = url.absoluteString
    if let cached = ImageCacher.shared.image(forKey: key) {
        return cached
    }
    
    let image = try await loadImageFromURL(from: url)
    ImageCacher.shared.setImage(image, forKey: key)
    return image
}
