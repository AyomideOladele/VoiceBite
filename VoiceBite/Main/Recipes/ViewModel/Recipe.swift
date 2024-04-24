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
    
    // Define a new struct to hold an instruction and their corresponding images
    struct Instruction: Codable, Hashable {
       var description: String
       var imageName: String
    }
    
    var instructions: [Instruction]
    
    // Define a new struct to hold nutrition value
    struct Nutrition: Codable, Hashable {
       var value: String
       var measurement: String
    }
    
    var nutritionalInformation: [Nutrition]
}

class RecipeManager: ObservableObject {
    
    @Published var recipes: [Recipe] = [
        
        Recipe(title: "Pesto Pasta", imageName: "PestoPasta", ingredients: ["Penne Pasta", "Pesto", "Oil", "Creme Fraiche"], instructions: [
            Recipe.Instruction(description: "Boil a pan of water with salt", imageName: "BoilingPotWater"),
            Recipe.Instruction(description: "Add pasta to water", imageName: "AppLogo"),
            Recipe.Instruction(description: "Heat frying pan", imageName: "AppLogo")],
            nutritionalInformation: [
            Recipe.Nutrition(value: "15 mins", measurement: "Preperation Time"),
            Recipe.Nutrition(value: "700 kcal", measurement: "Calories Per Serving"),
            Recipe.Nutrition(value: "1 hour", measurement: "Cooking Time"),
            Recipe.Nutrition(value: "2", measurement: "Servings")
        ]),
        
        Recipe(title: "Recipe 2", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step4", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step5", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step6", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step7", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step8", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step9", imageName: "AppLogo")],
               nutritionalInformation: [
               Recipe.Nutrition(value: "15 mins", measurement: "Preperation Time"),
               Recipe.Nutrition(value: "700 kcal", measurement: "Calories Per Serving"),
               Recipe.Nutrition(value: "1 hour", measurement: "Cooking Time"),
               Recipe.Nutrition(value: "2", measurement: "Servings")
           ]),
        
        Recipe(title: "Recipe 3", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo")],
               nutritionalInformation: [
               Recipe.Nutrition(value: "15 mins", measurement: "Preperation Time"),
               Recipe.Nutrition(value: "700 kcal", measurement: "Calories Per Serving"),
               Recipe.Nutrition(value: "1 hour", measurement: "Cooking Time"),
               Recipe.Nutrition(value: "2", measurement: "Servings")
           ]),
        
        Recipe(title: "Recipe 4", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo")],
               nutritionalInformation: [
               Recipe.Nutrition(value: "15 mins", measurement: "Preperation Time"),
               Recipe.Nutrition(value: "700 kcal", measurement: "Calories Per Serving"),
               Recipe.Nutrition(value: "1 hour", measurement: "Cooking Time"),
               Recipe.Nutrition(value: "2", measurement: "Servings")
           ]),
        
        Recipe(title: "Recipe 5", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo")],
               nutritionalInformation: [
               Recipe.Nutrition(value: "15 mins", measurement: "Preperation Time"),
               Recipe.Nutrition(value: "700 kcal", measurement: "Calories Per Serving"),
               Recipe.Nutrition(value: "1 hour", measurement: "Cooking Time"),
               Recipe.Nutrition(value: "2", measurement: "Servings")
           ]),
        
        Recipe(title: "Recipe 6", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo")],
               nutritionalInformation: [
               Recipe.Nutrition(value: "15 mins", measurement: "Preperation Time"),
               Recipe.Nutrition(value: "700 kcal", measurement: "Calories Per Serving"),
               Recipe.Nutrition(value: "1 hour", measurement: "Cooking Time"),
               Recipe.Nutrition(value: "2", measurement: "Servings")
           ]),
        
        Recipe(title: "Recipe 7", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo")],
               nutritionalInformation: [
               Recipe.Nutrition(value: "15 mins", measurement: "Preperation Time"),
               Recipe.Nutrition(value: "700 kcal", measurement: "Calories Per Serving"),
               Recipe.Nutrition(value: "1 hour", measurement: "Cooking Time"),
               Recipe.Nutrition(value: "2", measurement: "Servings")
           ]),
        
        Recipe(title: "Recipe 8", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo")],
               nutritionalInformation: [
               Recipe.Nutrition(value: "15 mins", measurement: "Preperation Time"),
               Recipe.Nutrition(value: "700 kcal", measurement: "Calories Per Serving"),
               Recipe.Nutrition(value: "1 hour", measurement: "Cooking Time"),
               Recipe.Nutrition(value: "2", measurement: "Servings")
           ]),
        
        Recipe(title: "Recipe 9", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo")],
               nutritionalInformation: [
               Recipe.Nutrition(value: "15 mins", measurement: "Preperation Time"),
               Recipe.Nutrition(value: "700 kcal", measurement: "Calories Per Serving"),
               Recipe.Nutrition(value: "1 hour", measurement: "Cooking Time"),
               Recipe.Nutrition(value: "2", measurement: "Servings")
           ]),
        
        Recipe(title: "Recipe 10", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo")],
               nutritionalInformation: [
               Recipe.Nutrition(value: "15 mins", measurement: "Preperation Time"),
               Recipe.Nutrition(value: "700 kcal", measurement: "Calories Per Serving"),
               Recipe.Nutrition(value: "1 hour", measurement: "Cooking Time"),
               Recipe.Nutrition(value: "2", measurement: "Servings")
           ])
    ]
}

    
    
