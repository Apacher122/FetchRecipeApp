//
//  Endpoints.swift
//  FetchRecipes
//
//  Created by pgAgent on 5/28/25.
//

import Foundation

enum Endpoints {
    static func getRecipeList(endpoint: String) -> URLRequest {
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/\(endpoint)")!
        return URLRequest(url: url)
    }
}
