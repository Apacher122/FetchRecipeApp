//
//  RecipeView.swift
//  FetchRecipes
//
//  Created by Rey Aparece on 5/28/25.
//

/// - Displays a title bar with a back button.
/// - Shows recipe name and cuisine type
/// - Loads and displays image from cache or URL
/// - Displays a link to the recipe source if available
/// - Attempts to show a YouTube video, otherwise displays the link
///
/// - Parameters:
///     - recipe: The `TestEntity` instance containing the recipe details

import SwiftUI
import WebKit

struct RecipeDetailView: View {
    @State private var failedToLoad = false
    @State private var image: UIImage?
    @Environment(\.dismiss) var dismiss
    let recipe: TestEntity


    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            TitleView(
                title: "Recipe Details",
                onBack: { dismiss() },
                onRefresh: nil
            )
            Text(recipe.name ?? "")
                .font(.system(size: 30, weight: .bold, design: .default))
                .padding(.vertical, 20)
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding()
            } else {
                ProgressView("Loading image...")
            }
            Text("Cuisine Type: \(recipe.cuisine ?? "")")
                .font(.title2)
                .padding()
            if hasInfo(recipe.sourceURL) {
                Link("View Recipe", destination: URL(string: recipe.sourceURL!)!)
            }
            if hasInfo(recipe.youtubeURL) {
                fetchYoutubeVideo(urlString: recipe.youtubeURL!)
            }
        }
        .task {
            await loadImage(url: recipe.photoURLLarge!)
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

    }
    
    @ViewBuilder
    func fetchYoutubeVideo(urlString: String) -> some View {
        if failedToLoad {
            Link("View Recipe Video", destination: URL(string: urlString)!)
                .font(.headline)
        } else {
            YouTubeView(urlString: urlString, failedToLoad: $failedToLoad)
                .aspectRatio(16/9, contentMode: .fit)
                .frame(maxWidth: .infinity)
                .clipped()
                .padding()
        }
    }
    
    func loadImage(url: String) async {
        do {
            let imageUrl = URL(string: url)
            async let fetchedImage = loadImageFromCache(from: imageUrl!)
            self.image = try await fetchedImage
        } catch {
            print("Could not load image")
        }
    }
    
    func hasInfo(_ str: String?) -> Bool {
        if let str = str, !str.isEmpty {
            return true
        }
        return false
    }
}

#Preview {
    let preview = PreviewPersistenceController.shared
    RecipeDetailView(recipe: preview.previewEntity)
}
