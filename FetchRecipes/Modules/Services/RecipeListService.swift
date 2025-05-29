//
//  RecipeListService.swift
//  FetchRecipes
//
//  Created by Rey Aparece on 5/28/25.
//

import Foundation

/// A Service responsible for fetching a list of recipes from a given endpoint
/// - NOTE: Uses 'RecipeAPIClient' to perform network requests to Fetch's provided endpoints
class RecipeListService {
    /// Gets list of recipes asynchronously from one of Fetch's provided endpoints
    ///
    /// - Parameter endPoint: The endpoint string to fetch the recipes from
    /// - Returns: An array of `Recipe` objects
    /// - Throws: An error if the network request or decoding fails
    func getRecipeList(endPoint: String) async throws -> [Recipe] {
        do {
            let response: RecipesRespone = try await RecipeAPIClient.shared.request(Endpoints.getRecipeList(endpoint: endPoint), as: RecipesRespone.self)
            return response.recipes
        } catch {
            throw (error)
        }
    }
}
