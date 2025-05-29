//
//  RecipeAPIClient.swift
//  FetchRecipes
//
//  Created by pgAgent on 5/28/25.
//
import Foundation

final class RecipeAPIClient {
    static let shared = RecipeAPIClient()
    private init() {}
    
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
