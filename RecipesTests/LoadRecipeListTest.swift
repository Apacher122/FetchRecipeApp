//
//  CorrectRecipeListTest.swift
//  RecipesTests
//
//  Created by pgAgent on 5/29/25.
//

import XCTest
@testable import FetchRecipes
import CoreData

final class CorrectRecipeListTest: XCTestCase {
    var viewModel: RecipeViewModel!
    var mockContext: NSManagedObjectContext!

    override func setUpWithError() throws {
        let container = NSPersistentContainer(name: "FetchRecipes")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { _, error in
            XCTAssertNil(error)
        }
        
        mockContext = container.viewContext
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        mockContext = nil
    }

    func testLoadRecipes() async throws {
        let viewModel = await RecipeViewModel(context: mockContext)
        await viewModel.loadRecipes(from: Constants.API.normalEndpoint)
        
        let fetchRequest: NSFetchRequest<TestEntity> = TestEntity.fetchRequest()
        let recipes = try mockContext.fetch(fetchRequest)
        
        XCTAssertFalse(recipes.isEmpty, "Expected recipes to be stored")
    }
    
    func testLoadMalformedRecipes() async throws {
        let viewModel = await RecipeViewModel(context: mockContext)
        await viewModel.loadRecipes(from: Constants.API.malformedEndpoint)
        
        let fetchRequest: NSFetchRequest<TestEntity> = TestEntity.fetchRequest()
        let recipes = try mockContext.fetch(fetchRequest)
        
        let containsPhrase = await viewModel.errorMessage?.contains("Failed to load recipe list")
        
        XCTAssertTrue((containsPhrase != nil), "Expected error to return")
    }
    
    func testLoadEmptyRecipes() async throws {
        let viewModel = await RecipeViewModel(context: mockContext)
        await viewModel.loadRecipes(from: Constants.API.emptyEndpoint)
        
        let fetchRequest: NSFetchRequest<TestEntity> = TestEntity.fetchRequest()
        let recipes = try mockContext.fetch(fetchRequest)
        
        XCTAssertTrue(recipes.isEmpty, "Expected list to return as empty")
    }

}
