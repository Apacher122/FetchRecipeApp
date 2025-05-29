//
//  FilterBar.swift
//  FetchRecipes
//
//  Created by Rey Aparece on 5/29/25.
//

/// Horizontal scrollable filter bar for selecting cuisines
///
/// Displays a unique list of cuisines, including "All" to show all
/// Highlights currently selected cuisine and updates `RecipeViewModel` to update the selected cuisine
///
/// - Parameters:
///     - viewModel: An observed object of type `RecipeViewModel` that manages a list of cuisines and the selected cuisine
///

import SwiftUI

struct FilterBar: View {
    @ObservedObject var viewModel: RecipeViewModel
    

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Button("All") {
                    viewModel.selectCuisine(nil)
                }
                .padding(0)
                .background(viewModel.selectedCuisine == nil ? Color.blue.opacity(0.2) : Color.clear)
                .cornerRadius(6)
                
                ForEach(viewModel.cuisines, id: \.self) { cuisine in
                    Button(cuisine) {
                        viewModel.selectCuisine(cuisine)
                    }
                    .padding(8)
                    .background(viewModel.selectedCuisine == cuisine ? Color.blue.opacity(0.2) : Color.clear)
                    .cornerRadius(6)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    let viewModel = RecipeViewModel()
    FilterBar(viewModel: viewModel)
}
