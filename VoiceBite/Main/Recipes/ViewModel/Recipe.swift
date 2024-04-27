//
//  Recipe.swift
//  VoiceBite
//
// A simple data model for a recipe
//
import Foundation

struct Recipe: Identifiable, Codable{
    var id = UUID()
    var title: String
    var imageName: String
    var ingredients: [String]
    var utensils: [String]
    var nutritionalInfo: [String] // Contains 3 values in order of carbohydrates, fats and proteins
    
    // Define a new struct to hold an instruction and their corresponding images
    struct Instruction: Codable, Hashable {
        var description: String
        var details: [String]
        var imageName: String
    }
    
    var instructions: [Instruction]
    
    // Define a new struct to hold recipe metrics
    struct Metric: Codable, Hashable {
        var detail: String
        var label: String
    }
    
    var recipeMetrics: [Metric]
}

class RecipeManager: ObservableObject {
    
    @Published var recipes: [Recipe] = [
        
        Recipe(title: "Pesto Pasta", imageName: "PestoPasta", ingredients: ["200g Pasta", "2 Garlic Cloves", "25g Basil Leaves", "30g Pine Nuts", "25g Grated Parmesan Cheese", "60ml Olive Oil", "Black Pepper", "Salt"], utensils: ["Medium Pot", "Food Processor", "Strainer", "Small Bowl"], nutritionalInfo: ["35", "40", "15"],
            instructions: [
            Recipe.Instruction(description: "Prepare Pesto", details: ["a) Put basil, pine nuts, garlic and 3/4 of the parmesean into food processor and pulse until finely chopped", "b) While the food processor is running, slowly combine olive oil until fully combined", "c) Continue pulsing until mixture is smooth"], imageName: "MixingPesto"),
            Recipe.Instruction(description: "Cook Pasta", details: ["a) Fill pot with water, add a pinch of salt and bring to boil", "b) Add pasta and cook for 10 to 12 minutes until al dente", "c) Once cooked, drain pasta and reserve 250ml of pasta water"], imageName: "BoilingPotWater"),
            Recipe.Instruction(description: "Combine Pesto and Pasta", details: ["a) Return the pasta to the pot", "b) Add pasta water and pesto to pot and mix well"], imageName: "PestoPasta"),
            Recipe.Instruction(description: "Recipe Complete!", details: ["a) Serve pasta into two bowls, add parmesean cheese and black pepper to taste"], imageName: "PestoPasta")],
            recipeMetrics: [
            Recipe.Metric(detail: "15 mins", label: "Preperation Time"),
            Recipe.Metric(detail: "500 kcal", label: "Calories Per Serving"),
            Recipe.Metric(detail: "1 hour", label: "Cooking Time"),
            Recipe.Metric(detail: "2", label: "Servings")
            ]),
        
        Recipe(title: "Recipe 2", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], utensils: ["Saucepan", "Colander", "Wooden Spoon", "Frying Pan"],
            nutritionalInfo: ["20", "30", "10"],
            instructions: [
            Recipe.Instruction(description: "Step1", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo")],
               recipeMetrics: [
               Recipe.Metric(detail: "15 mins", label: "Preperation Time"),
               Recipe.Metric(detail: "700 kcal", label: "Calories Per Serving"),
               Recipe.Metric(detail: "1 hour", label: "Cooking Time"),
               Recipe.Metric(detail: "2", label: "Servings")
           ]),
        
        Recipe(title: "Recipe 3", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], utensils: ["Saucepan", "Colander", "Wooden Spoon", "Frying Pan"],
               nutritionalInfo: ["20", "30", "10"],
               instructions: [
            Recipe.Instruction(description: "Step1", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo")],
               recipeMetrics: [
               Recipe.Metric(detail: "15 mins", label: "Preperation Time"),
               Recipe.Metric(detail: "700 kcal", label: "Calories Per Serving"),
               Recipe.Metric(detail: "1 hour", label: "Cooking Time"),
               Recipe.Metric(detail: "2", label: "Servings")
           ]),
        
        Recipe(title: "Recipe 4", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], utensils: ["Saucepan", "Colander", "Wooden Spoon", "Frying Pan"],
               nutritionalInfo: ["20", "30", "10"],
               instructions: [
            Recipe.Instruction(description: "Step1", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo")],
               recipeMetrics: [
               Recipe.Metric(detail: "15 mins", label: "Preperation Time"),
               Recipe.Metric(detail: "700 kcal", label: "Calories Per Serving"),
               Recipe.Metric(detail: "1 hour", label: "Cooking Time"),
               Recipe.Metric(detail: "2", label: "Servings")
           ]),
        
        Recipe(title: "Recipe 5", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], utensils: ["Saucepan", "Colander", "Wooden Spoon", "Frying Pan"],
               nutritionalInfo: ["20", "30", "10"],
               instructions: [
            Recipe.Instruction(description: "Step1", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo")],
               recipeMetrics: [
               Recipe.Metric(detail: "15 mins", label: "Preperation Time"),
               Recipe.Metric(detail: "700 kcal", label: "Calories Per Serving"),
               Recipe.Metric(detail: "1 hour", label: "Cooking Time"),
               Recipe.Metric(detail: "2", label: "Servings")
           ]),
        
        Recipe(title: "Recipe 6", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], utensils: ["Saucepan", "Colander", "Wooden Spoon", "Frying Pan"],
               nutritionalInfo: ["20", "30", "10"],
               instructions: [
            Recipe.Instruction(description: "Step1", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo")],
               recipeMetrics: [
               Recipe.Metric(detail: "15 mins", label: "Preperation Time"),
               Recipe.Metric(detail: "700 kcal", label: "Calories Per Serving"),
               Recipe.Metric(detail: "1 hour", label: "Cooking Time"),
               Recipe.Metric(detail: "2", label: "Servings")
           ]),
        
        Recipe(title: "Recipe 7", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], utensils: ["Saucepan", "Colander", "Wooden Spoon", "Frying Pan"],
               nutritionalInfo: ["20", "30", "10"],
               instructions: [
            Recipe.Instruction(description: "Step1", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo")],
               recipeMetrics: [
               Recipe.Metric(detail: "15 mins", label: "Preperation Time"),
               Recipe.Metric(detail: "700 kcal", label: "Calories Per Serving"),
               Recipe.Metric(detail: "1 hour", label: "Cooking Time"),
               Recipe.Metric(detail: "2", label: "Servings")
           ]),
        
        Recipe(title: "Recipe 8", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], utensils: ["Saucepan", "Colander", "Wooden Spoon", "Frying Pan"],
               nutritionalInfo: ["20", "30", "10"],
               instructions: [
            Recipe.Instruction(description: "Step1", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo")],
               recipeMetrics: [
               Recipe.Metric(detail: "15 mins", label: "Preperation Time"),
               Recipe.Metric(detail: "700 kcal", label: "Calories Per Serving"),
               Recipe.Metric(detail: "1 hour", label: "Cooking Time"),
               Recipe.Metric(detail: "2", label: "Servings")
           ]),
        
        Recipe(title: "Recipe 9", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], utensils: ["Saucepan", "Colander", "Wooden Spoon", "Frying Pan"],
               nutritionalInfo: ["20", "30", "10"],
               instructions: [
            Recipe.Instruction(description: "Step1", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo")],
               recipeMetrics: [
               Recipe.Metric(detail: "0", label: "Preperation Time"),
               Recipe.Metric(detail: "0", label: "Calories Per Serving"),
               Recipe.Metric(detail: "0", label: "Cooking Time"),
               Recipe.Metric(detail: "0", label: "Servings")
           ]),
        
        Recipe(title: "Recipe 10", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], utensils: ["Saucepan", "Colander", "Wooden Spoon", "Frying Pan"],
               nutritionalInfo: ["20", "30", "10"],
               instructions: [
            Recipe.Instruction(description: "Step1", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo")],
               recipeMetrics: [
               Recipe.Metric(detail: "0", label: "Preperation Time"),
               Recipe.Metric(detail: "0", label: "Calories Per Serving"),
               Recipe.Metric(detail: "0", label: "Cooking Time"),
               Recipe.Metric(detail: "0", label: "Servings")
           ])
    ]
}

    
    
