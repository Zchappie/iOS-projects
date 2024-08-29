import SwiftUI
import SwiftData

/// The main view that appears when the app is launched.
struct ContentView: View {
    @Environment(\.modelContext) private var context
    
    @Query var recipes: [Recipe]
    @Query var ingredients: [Ingredient]
    @Query var categories: [Category]

  var body: some View {
    TabView {
      RecipesView()
        .tabItem {
          Label("Recipes", systemImage: "frying.pan")
        }

      CategoriesView()
        .tabItem {
          Label("Categories", systemImage: "tag")
        }

      IngredientsView()
        .tabItem {
          Label("Ingredients", systemImage: "carrot")
        }
    }
  }
}
