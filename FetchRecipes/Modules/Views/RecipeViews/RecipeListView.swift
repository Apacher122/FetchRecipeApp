//
//  HomeView.swift
//  FetchRecipes
//
//  Created by pgAgent on 5/28/25.
//

import SwiftUI
import CoreData

struct RecipeListView: View {
    @ObservedObject var viewModel: RecipeViewModel = RecipeViewModel()
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) var dismiss
    var endPoint: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            TitleView(
                title: "Recipes",
                onBack: { dismiss() },
                onRefresh: { Task {await viewModel.loadRecipes(from: endPoint)} }
            )
            if viewModel.isLoading {
                LoadingView()
            } else if let error = viewModel.errorMessage {
                ErrorView(error: error)
            } else if viewModel.filteredRecipes.isEmpty {
                Text("No recipes found!")
                    .foregroundColor(.gray)
                    .italic()
            } else {
                buildList()
            }
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .task {
            print("loading recipes")
            await viewModel.loadRecipes(from: endPoint)
        }
    }
    
    @ViewBuilder
    func buildList() -> some View {
        FilterBar(viewModel: viewModel)
        List(viewModel.filteredRecipes, id: \.self) { recipe in
            VStack(alignment: .leading, spacing: 4) {
                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                    Text(recipe.name ?? "Unknown")
                        .font(.headline)
                }
            }
            .padding(.vertical, 4)
        }
    }
}

#Preview {
    let persistenceController = PersistenceController.preview
    let context = persistenceController.container.viewContext
    let viewModel = RecipeViewModel()
    
    RecipeListView(viewModel: viewModel, endPoint: "recipes")
        .environment(\.managedObjectContext, context)

}


