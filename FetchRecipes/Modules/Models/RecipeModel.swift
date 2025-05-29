//
//  Recipes.swift
//  FetchRecipes
//
//  Created by Rey Aparece on 5/28/25.
//

import Foundation

struct RecipesRespone: Decodable {
    let recipes: [Recipe]
}

struct Recipe: Codable, Identifiable {
    var id: String { uuid }
    let cuisine: String
    let name: String
    let photoURLLarge: String?
    let photoURLSmall: String?
    let uuid: String
    let sourceURL: String?
    let youtubeURL: String?
    
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case uuid
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}
