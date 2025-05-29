//
//  ImageCacher.swift
//  FetchRecipes
//
//  Created by Rey Aparece on 5/28/25.
//

/// Thread-safe singleton class responsible for caching images in memory using `NSCache`
///
/// `ImageCacher` will provide a shared instance for storing and retrieving images by a string key,
/// helping to improve performance by mitigating redundant image loading

import Foundation
import UIKit

final class ImageCacher {
    static let shared = ImageCacher()
    
    private let cache = NSCache<NSString, UIImage>()
    
    func image(forKey key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
    
    func setImage(_ image: UIImage, forKey key: String){
        cache.setObject(image, forKey: key as NSString)
    }
    
}
