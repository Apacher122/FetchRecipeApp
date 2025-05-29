//
//  ContentView.swift
//  FetchRecipes
//
//  Created by Rey Aparece on 5/28/25.
//

/// Main content view for the app
///
/// Displays a navigation menu with three options to display different scenarios:
/// - Scenario 1: Successful Recipe JSON Data
/// - Scenario 2: Malformed Recipe JSON Data
/// - Scenario 3: Empty Recipe JSON Data

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                NavigationLink(
                    destination: RecipeListView(endPoint: Constants.API.normalEndpoint)
                ){
                    Text("Normal Recipe List")
                        .font(.headline)
                }
                NavigationLink(
                    destination: RecipeListView(endPoint: Constants.API.malformedEndpoint)
                ){
                    Text("Malformed Recipe List")
                        .font(.headline)
                }
                NavigationLink(
                    destination: RecipeListView(endPoint: Constants.API.emptyEndpoint)
                ){
                    Text("Empty Recipe List")
                        .font(.headline)
                }
            }
            .navigationBarHidden(true)
        }
    }
}


#Preview {
    ContentView()
}
