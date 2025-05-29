//
//  RecipeViewModel.swift
//  FetchRecipes
//
//  Created by Rey Aparece on 5/28/25.
//

/// ViewModel responsible for managing recipe data and preparing it for UI updates
///
/// - Properties:
///     - context: Core Data managed object context used for data operations
///     - errorMessage: Optional string to display error messages
///     - isLoading: Boolean to see if there is a loading operation in progress
///     - recipes: Complete list of recipes fetched from Core Data
///     - filteredRecipes: List of recipes filtered by user-selected cuisine
///     - selectedCuisine: Currently selected cuisine, used for filtering
///
/// - Methods
///     - init(context:): Initializes the view model with a provided or default Core Data context
///     - loadRecipes(from:): Asyncrhonously fetches recipes from the provided API endpoints, saves to Core Data, and updates local list
///     - selectCuisine(_:): Sets the selected Cuisine and applies the filter to the current list of recipes
///     - fetchRecipesFromData(): Fetches recipes from Core Data, extracts cuisines, and applies current filter
///     - extractCuisines(): Exracts unique cuisines from the current recipe list and updates the list of cuisines
///     - applyFilter(): Filters the recipes based on the selected cuisine
///     - saveData(_:): Saves or updates recipes in Core Data, and deletes any missing or invalid entries from the latest API response
///

import Foundation
import CoreData

@MainActor
class RecipeViewModel: ObservableObject {
    let context: NSManagedObjectContext
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var recipes: [TestEntity] = []
    @Published var filteredRecipes: [TestEntity] = []
    @Published var cuisines: [String] = []
    @Published var selectedCuisine: String?
    private(set) var recipesLoadState = false
    
    private let persistanceController = PersistenceController.shared
    
    init (context: NSManagedObjectContext? = nil) {
        let ctx = context ?? persistanceController.container.viewContext
        self.context = ctx
    }
    
    private let recipeListService = RecipeListService()
    
    func loadRecipes(from endPoint: String) async {
        print("attempting to fetch recipes")
        guard !recipesLoadState else { return }
        recipesLoadState = true
        DispatchQueue.main.async { self.isLoading = true }
        do {
            let result: [Recipe] = try await recipeListService.getRecipeList(endPoint: endPoint)
            try await self.saveData(result)
            fetchRecipesFromData()
        } catch {
            errorMessage = "Failed to load recipe list: \(error.localizedDescription)"
            print(errorMessage!)
        }
        DispatchQueue.main.async { self.isLoading = false }
    }
    
    func selectCuisine(_ cuisine: String?) {
        selectedCuisine = cuisine
        applyFilter()
    }
    
    func fetchRecipesFromData() {
        let request: NSFetchRequest<TestEntity> = TestEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        do {
            let results = try context.fetch(request)
            recipes = results
            extractCuisines()
            applyFilter()
        } catch {
            print("Failed to fetch recipes from Core Data: \(error.localizedDescription)")
            errorMessage = "Failed to load recipes from local data"
        }
    }
    
    func reset() {
        recipesLoadState = false
        recipes = []
    }
    
    private func extractCuisines() {
        let raw = recipes.compactMap { $0.cuisine }
        let uniqueCuisines = Array(Set(raw)).sorted()
        DispatchQueue.main.async {
            self.cuisines = uniqueCuisines
        }
    }
    
    private func applyFilter() {
        if let cuisine = selectedCuisine {
            filteredRecipes = recipes.filter { $0.cuisine == cuisine }
        } else {
            filteredRecipes = recipes
        }
    }

    private func saveData(_ recipes: [Recipe]) async throws {
        let fetchRequest: NSFetchRequest<TestEntity> = TestEntity.fetchRequest()
        
        do {
            let currentRecipes = try context.fetch(fetchRequest)
            var existingEntries = Dictionary(uniqueKeysWithValues: currentRecipes.map { ($0.uuid ?? "", $0) })
            
            for recipe in recipes {
                // Data Validation

                if let exists = existingEntries[recipe.uuid] {
                    exists.cuisine = recipe.cuisine
                    exists.name = recipe.name
                    exists.photoURLLarge = recipe.photoURLLarge
                    exists.photoURLSmall = recipe.photoURLSmall
                    exists.uuid = recipe.uuid
                    exists.sourceURL = recipe.sourceURL
                    exists.youtubeURL = recipe.youtubeURL
                    
                    existingEntries.removeValue(forKey: recipe.uuid)
                } else {
                    let newEntry = TestEntity(context: context)
                    newEntry.cuisine = recipe.cuisine
                    newEntry.name = recipe.name
                    newEntry.photoURLLarge = recipe.photoURLLarge
                    newEntry.photoURLSmall = recipe.photoURLSmall
                    newEntry.uuid = recipe.uuid
                    newEntry.sourceURL = recipe.sourceURL
                    newEntry.youtubeURL = recipe.youtubeURL
                }
            }
            
            for (_, entry) in existingEntries {
                context.delete(entry)
            }
            
            try context.save()
        } catch {
            self.errorMessage = "Save to Core Data failed: \(error.localizedDescription)"
        }
    }
}
