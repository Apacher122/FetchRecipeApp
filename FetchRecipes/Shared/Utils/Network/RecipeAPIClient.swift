//
//  RecipeAPIClient.swift
//  FetchRecipes
//
//  Created by Rey Aparece on 5/28/25.
//

/// A singleton API Client that will make network requests and decode JSON data

import Foundation

final class RecipeAPIClient {
    static let shared = RecipeAPIClient()
    private init() {}
    
    /// Performs asynchronous network requests and decodes the response
    /// - Parameters:
    ///     - request: the `URLRequest` to be executed
    ///     - type: The expected `Decodable` type to deocde the response to
    /// - Returns: An instance of the decoded type `T`
    /// - Throws:
    ///     - `URLError` if server response is invalid
    ///     - Decoding errors if response data cannot be handled
    func request<T: Decodable>(_ request: URLRequest, as type: T.Type) async throws -> T {
        print("fetching list")
        let (data, res) = try await URLSession.shared.data(for: request)
        guard let httpsResponse = res as? HTTPURLResponse,
              (200..<300).contains(httpsResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        // Validate Data
        do {
            let jsonData = try JSONDecoder().decode(T.self, from: data)
            return jsonData
        } catch {
            throw error
        }
    }
}
