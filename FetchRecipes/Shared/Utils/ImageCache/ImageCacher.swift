//
//  ImageCacher.swift
//  FetchRecipes
//
//  Created by pgAgent on 5/28/25.
//

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
