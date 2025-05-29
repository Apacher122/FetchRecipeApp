//
//  ContentView.swift
//  FetchRecipes
//
//  Created by Rey Aparece on 5/28/25.
//

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
