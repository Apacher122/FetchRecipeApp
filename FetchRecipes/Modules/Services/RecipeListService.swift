//
//  RecipeListService.swift
//  FetchRecipes
//
//  Created by pgAgent on 5/28/25.
//

import Foundation

class RecipeListService {
    func getRecipeList(endPoint: String) async throws -> [Recipe] {
        do {
            let response: RecipesRespone = try await RecipeAPIClient.shared.request(Endpoints.getRecipeList(endpoint: endPoint), as: RecipesRespone.self)
            return response.recipes
        } catch {
            throw (error)
        }
    }
}
