//
//  ImageLoader.swift
//  FetchRecipes
//
//  Created by Rey Aparece on 5/28/25.
//
import Foundation
import UIKit

/// Loads an image asyncronously from the specified URL
///
/// - Parameter url: The image url
/// - Returns: A `UIImage` from provided URL
/// - Throws: Error if image data cannot be loaded or converted to `UIImage`
func loadImageFromURL(from url: URL) async throws -> UIImage {
    let (data, _) = try await URLSession.shared.data(from: url)
    guard let image = UIImage (data: data) else  {
        throw URLError(.badServerResponse)
    }
    return image
}

/// Loads image asynchronously from cache if available, otherwise fetch it from the provided URL and cache it
///
/// - Parameter url: The image url
/// - Returns: A `UIImage` from cache, otherwise from a provided URL
/// - Throws: Error if image cannot be loaded
func loadImageFromCache(from url: URL) async throws -> UIImage {
    let key = url.absoluteString
    if let cached = ImageCacher.shared.image(forKey: key) {
        return cached
    }
    
    let image = try await loadImageFromURL(from: url)
    ImageCacher.shared.setImage(image, forKey: key)
    return image
}
