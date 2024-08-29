import Foundation
import SwiftData

@Model
class Category: Identifiable, Hashable {
    var id: UUID
    var name: String
    var recipes: [Recipe]

    init(id: UUID = UUID(), name: String = "", recipes: [Recipe] = []) {
        self.id = id
        self.name = name
        self.recipes = recipes
    }
}

@Model
class Ingredient: Identifiable, Hashable {
    let id: UUID
    var name: String

    init(id: UUID = UUID(), name: String = "") {
        self.id = id
        self.name = name
    }
}

@Model
class RecipeIngredient: Identifiable, Hashable {
    let id: UUID
    var ingredient: Ingredient
    var quantity: String

    init(id: UUID = UUID(), ingredient: Ingredient = Ingredient(), quantity: String = "") {
        self.id = id
        self.ingredient = ingredient
        self.quantity = quantity
    }
}

@Model
class Recipe: Identifiable, Hashable {
    let id: UUID
    var name: String
    var summary: String
    var category: Category?
    var serving: Int
    var time: Int
    var ingredients: [RecipeIngredient]
    var instructions: String
    var imageData: Data?

    init(
        id: UUID = UUID(),
        name: String = "",
        summary: String = "",
        category: Category? = nil,
        serving: Int = 1,
        time: Int = 5,
        ingredients: [RecipeIngredient] = [],
        instructions: String = "",
        imageData: Data? = nil
    ) {
        self.id = id
        self.name = name
        self.summary = summary
        self.category = category
        self.serving = serving
        self.time = time
        self.ingredients = ingredients
        self.instructions = instructions
        self.imageData = imageData
    }
}
