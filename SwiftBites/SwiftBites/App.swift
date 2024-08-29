import SwiftData
import SwiftUI

@MainActor
let modelContainer: ModelContainer = {
    do {
        let schema = Schema([Ingredient.self, Category.self, Recipe.self, RecipeIngredient.self])
        let configuration = ModelConfiguration() // only modify if StoredInMemoryOnly, ReadOnly, etc.
        let container = try ModelContainer(for: schema, configurations: configuration)
        
        // Make sure the persistent store is empty. If it's not, return the non-empty container. Ref: https://www.andrewcbancroft.com/blog/ios-development/data-persistence/pre-populate-swiftdata-persistent-store/
        var itemFetchDescriptor = FetchDescriptor<Ingredient>()
        itemFetchDescriptor.fetchLimit = 1
        guard try container.mainContext.fetch(itemFetchDescriptor).count == 0 else { return container }
        
        // Load pre-populate data
        var defaultValues = DefaultValues()
        for ingredient in defaultValues.ingredients {
            container.mainContext.insert(ingredient)
        }
        for recipe in defaultValues.recipes {
            container.mainContext.insert(recipe)
        }
        for category in defaultValues.categories {
            container.mainContext.insert(category)
        }
        
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()

@main
@MainActor
struct SwiftBitesApp: App {
//    @StateObject private var modelContainer = ModelContainer( [Ingredient.self, Category.self, Recipe.self, RecipeIngredient.self])
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
        }
    }
}
