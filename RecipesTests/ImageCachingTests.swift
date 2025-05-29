//
//  testImageCaching.swift
//  FetchRecipesUITests
//
//  Created by pgAgent on 5/29/25.
//

import XCTest
@testable import FetchRecipes

final class ImageCachingTests: XCTestCase {
    func testImageCachingStorageAndRetrieval() {
        let url = "https://www.test.com/image.png"
        let image = UIImage(systemName: "star")!
        
        ImageCacher.shared.setImage(image, forKey: url)
        let cachedImage = ImageCacher.shared.image(forKey: url)
        
        XCTAssertNotNil(cachedImage, "Expected cached")
        XCTAssertEqual(cachedImage?.pngData(), image.pngData(), "Expected cached image to match source image")
    }
    
    func testImageCacheMissReturnsNil() {
        let url = "https://www.test.com/oops.png"
        
        let cachedImage = ImageCacher.shared.image(forKey: url)
        
        XCTAssertNil(cachedImage, "Expected nil for uncached image")
    }
}
