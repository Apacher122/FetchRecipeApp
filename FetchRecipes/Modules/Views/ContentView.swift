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
            VStack(spacing: 16) {
                buildTitle()
                buildMenu()
            }
            .navigationBarHidden(true)
        }
    }
    
    @ViewBuilder
    func buildTitle() -> some View {
        VStack {
            Image("DogLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250)
                .background(
                    Circle()
                        .fill(.red)
                )
            Text("Fetch A Recipe")
                .font(.system(size: 36, weight: .bold, design: .default))
                .foregroundColor(Color.primary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .zIndex(1)
    }
    
    @ViewBuilder
    func buildMenu() -> some View {
        VStack {
            Text("Select a list below")
                .font(.title2)
                .bold()
                .padding([.top, .leading,.trailing])
            ScrollView {
                LazyVStack(alignment: .center){
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
            }
        }
    }
}


#Preview {
    ContentView()
}
