//
//  FetchRecipesApp.swift
//  FetchRecipes
//
//  Created by Rey Aparece on 5/28/25.
//

import SwiftUI

@main
struct FetchRecipesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
