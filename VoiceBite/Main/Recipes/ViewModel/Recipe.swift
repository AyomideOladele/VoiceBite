//
//  Recipe.swift
//  VoiceBite
//
// A simple data model for a recipe
//
// TODO: Link recipes with Firebase database?

import Foundation

struct Recipe: Identifiable, Codable{
    var id = UUID()
    var title: String
    var imageName: String
    var ingredients: [String]
    var utensils: [String]
    var nutritionalInfo: [String] // 3 values in order of carbohydrates, fats and proteins
    
    // Define a new struct to hold an instruction and their corresponding images
    struct Instruction: Codable, Hashable {
       var description: String
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
        
        Recipe(title: "Pesto Pasta", imageName: "PestoPasta", ingredients: ["Penne Pasta", "Pesto", "Oil", "Creme Fraiche"], utensils: ["Saucepan", "Colander", "Wooden Spoon", "Frying Pan"], nutritionalInfo: ["20", "30", "10"],
            instructions: [
            Recipe.Instruction(description: "Boil a pan of water with salt", imageName: "BoilingPotWater"),
            Recipe.Instruction(description: "Add pasta to water", imageName: "AppLogo"),
            Recipe.Instruction(description: "Heat frying pan", imageName: "AppLogo")],
            recipeMetrics: [
            Recipe.Metric(detail: "15 mins", label: "Preperation Time"),
            Recipe.Metric(detail: "700 kcal", label: "Calories Per Serving"),
            Recipe.Metric(detail: "1 hour", label: "Cooking Time"),
            Recipe.Metric(detail: "2", label: "Servings")
            ]),
        
        Recipe(title: "Recipe 2", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], utensils: ["Saucepan", "Colander", "Wooden Spoon", "Frying Pan"],
               nutritionalInfo: ["20", "30", "10"],
               instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step4", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step5", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step6", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step7", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step8", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step9", imageName: "AppLogo")],
               recipeMetrics: [
               Recipe.Metric(detail: "15 mins", label: "Preperation Time"),
               Recipe.Metric(detail: "700 kcal", label: "Calories Per Serving"),
               Recipe.Metric(detail: "1 hour", label: "Cooking Time"),
               Recipe.Metric(detail: "2", label: "Servings")
           ]),
        
        Recipe(title: "Recipe 3", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], utensils: ["Saucepan", "Colander", "Wooden Spoon", "Frying Pan"],
               nutritionalInfo: ["20", "30", "10"],
               instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo")],
               recipeMetrics: [
               Recipe.Metric(detail: "15 mins", label: "Preperation Time"),
               Recipe.Metric(detail: "700 kcal", label: "Calories Per Serving"),
               Recipe.Metric(detail: "1 hour", label: "Cooking Time"),
               Recipe.Metric(detail: "2", label: "Servings")
           ]),
        
        Recipe(title: "Recipe 4", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], utensils: ["Saucepan", "Colander", "Wooden Spoon", "Frying Pan"],
               nutritionalInfo: ["20", "30", "10"],
               instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo")],
               recipeMetrics: [
               Recipe.Metric(detail: "15 mins", label: "Preperation Time"),
               Recipe.Metric(detail: "700 kcal", label: "Calories Per Serving"),
               Recipe.Metric(detail: "1 hour", label: "Cooking Time"),
               Recipe.Metric(detail: "2", label: "Servings")
           ]),
        
        Recipe(title: "Recipe 5", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], utensils: ["Saucepan", "Colander", "Wooden Spoon", "Frying Pan"],
               nutritionalInfo: ["20", "30", "10"],
               instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo")],
               recipeMetrics: [
               Recipe.Metric(detail: "15 mins", label: "Preperation Time"),
               Recipe.Metric(detail: "700 kcal", label: "Calories Per Serving"),
               Recipe.Metric(detail: "1 hour", label: "Cooking Time"),
               Recipe.Metric(detail: "2", label: "Servings")
           ]),
        
        Recipe(title: "Recipe 6", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], utensils: ["Saucepan", "Colander", "Wooden Spoon", "Frying Pan"],
               nutritionalInfo: ["20", "30", "10"],
               instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo")],
               recipeMetrics: [
               Recipe.Metric(detail: "15 mins", label: "Preperation Time"),
               Recipe.Metric(detail: "700 kcal", label: "Calories Per Serving"),
               Recipe.Metric(detail: "1 hour", label: "Cooking Time"),
               Recipe.Metric(detail: "2", label: "Servings")
           ]),
        
        Recipe(title: "Recipe 7", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], utensils: ["Saucepan", "Colander", "Wooden Spoon", "Frying Pan"],
               nutritionalInfo: ["20", "30", "10"],
               instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo")],
               recipeMetrics: [
               Recipe.Metric(detail: "15 mins", label: "Preperation Time"),
               Recipe.Metric(detail: "700 kcal", label: "Calories Per Serving"),
               Recipe.Metric(detail: "1 hour", label: "Cooking Time"),
               Recipe.Metric(detail: "2", label: "Servings")
           ]),
        
        Recipe(title: "Recipe 8", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], utensils: ["Saucepan", "Colander", "Wooden Spoon", "Frying Pan"],
               nutritionalInfo: ["20", "30", "10"],
               instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo")],
               recipeMetrics: [
               Recipe.Metric(detail: "15 mins", label: "Preperation Time"),
               Recipe.Metric(detail: "700 kcal", label: "Calories Per Serving"),
               Recipe.Metric(detail: "1 hour", label: "Cooking Time"),
               Recipe.Metric(detail: "2", label: "Servings")
           ]),
        
        Recipe(title: "Recipe 9", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], utensils: ["Saucepan", "Colander", "Wooden Spoon", "Frying Pan"],
               nutritionalInfo: ["20", "30", "10"],
               instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo")],
               recipeMetrics: [
               Recipe.Metric(detail: "0", label: "Preperation Time"),
               Recipe.Metric(detail: "0", label: "Calories Per Serving"),
               Recipe.Metric(detail: "0", label: "Cooking Time"),
               Recipe.Metric(detail: "0", label: "Servings")
           ]),
        
        Recipe(title: "Recipe 10", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], utensils: ["Saucepan", "Colander", "Wooden Spoon", "Frying Pan"],
               nutritionalInfo: ["20", "30", "10"],
               instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo")],
               recipeMetrics: [
               Recipe.Metric(detail: "0", label: "Preperation Time"),
               Recipe.Metric(detail: "0", label: "Calories Per Serving"),
               Recipe.Metric(detail: "0", label: "Cooking Time"),
               Recipe.Metric(detail: "0", label: "Servings")
           ])
    ]
}

    
    
