//
//  Endpoints.swift
//  FetchRecipes
//
//  Created by Rey Aparece on 5/28/25.
//

import Foundation

enum Endpoints {

    /// Creates a `URLRequest` for an endpoint provided by Fetch
    ///
    /// - Parameter endpoint: Enpoint path to be appended to the base URL
    /// - Returns:  A `URLRequest` configured with the full URL for the endpoint
    static func getRecipeList(endpoint: String) -> URLRequest {
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/\(endpoint)")!
        return URLRequest(url: url)
    }
}
