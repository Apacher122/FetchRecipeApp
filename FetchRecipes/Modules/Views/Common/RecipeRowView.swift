//
//  RecipeRowView.swift
//  FetchRecipes
//
//  Created by pgAgent on 5/29/25.
//

/// View to generate recipe rows with a small image preview
///
/// - Parameters:
///     - recipe: TestEntity that contains the recipe info

import SwiftUI

struct RecipeRowView: View {
    let recipe: TestEntity
    @State private var image: UIImage?

    var body: some View {
        HStack(spacing: 16) {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
                    .padding()
            }
            Text(recipe.name ?? "")
                .font(.headline)
                .bold()
        }
        .task {
            if (recipe.photoURLSmall != nil) {
                await loadImage(url: recipe.photoURLSmall!)
            }
        }
    }
    
    func loadImage(url: String) async {
        do {
            let imageUrl = URL(string: url)
            async let fetchedImage = loadImageFromCache(from: imageUrl!)
            self.image = try await fetchedImage
        } catch {
            print("Could not load image for \(recipe.name ?? "")")
        }
    }
}

#Preview {
    let preview = PreviewPersistenceController.shared
    RecipeRowView(recipe: preview.previewEntity)
}
