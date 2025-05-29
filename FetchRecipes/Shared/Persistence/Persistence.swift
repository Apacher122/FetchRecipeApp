//
//  Persistence.swift
//  FetchRecipes
//
//  Created by Rey Aparece on 5/28/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static let inMemory: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        return controller
    }()

    @MainActor
    static let preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext
        let sampleData = TestEntity(context: viewContext)
        sampleData.name = "Crunchwrap Supreme"
        sampleData.cuisine = "Taco Bell"
        sampleData.photoURLLarge = "example.com"
        sampleData.photoURLSmall = "examplebutsmaller.com"
        sampleData.uuid = "abc123"
        sampleData.sourceURL = "source.com"
        sampleData.youtubeURL = "youtube.com"
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return controller
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "FetchRecipes")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

struct PreviewPersistenceController {
    static let shared = PreviewPersistenceController()
    let container: NSPersistentContainer
    let previewEntity: TestEntity
    
    init() {
        container = NSPersistentContainer(name: "FetchRecipes")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error loading preview Store: \(error)")
            }
        }
        
        let viewContext = container.viewContext
        let recipe = TestEntity(context: viewContext)
        recipe.cuisine = "The Finest Cuisine"
        recipe.name = "Crunchwrap Supreme"
        recipe.photoURLLarge = "photo.com"
        recipe.photoURLSmall = "photobutsmaller.com"
        recipe.uuid = "123abc"
        recipe.sourceURL = "source.com"
        recipe.youtubeURL = "https://www.youtube.com/watch?v=6R8ffRRJcrg"
        
        try? viewContext.save()
        self.previewEntity = recipe
    }
}
