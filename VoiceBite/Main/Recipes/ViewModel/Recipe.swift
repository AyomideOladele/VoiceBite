//
//  Recipe.swift
//  VoiceBite
//
//  Created by Ayomide Oladele on 15/04/2024.
//
// Development goal: Link recipes with Firebase database?

import Foundation

struct Recipe: Identifiable, Codable{
    var id = UUID()
    var title: String
    var imageName: String
    var ingredients: [String]
    
    // Define a new struct to hold instructions and their corresponding images
    struct Instruction: Codable, Hashable {
       var description: String
       var imageName: String
    }
    
    var instructions: [Instruction]
    
}

class RecipeManager: ObservableObject {
    
    @Published var recipes: [Recipe] = [
        
        Recipe(title: "Pesto Pasta", imageName: "PestoPasta", ingredients: ["Penne Pasta", "Pesto", "Oil", "Creme Fraiche"], instructions: [
            Recipe.Instruction(description: "Boil a pan of water with salt", imageName: "BoilingPotWater"),
            Recipe.Instruction(description: "Add pasta to water", imageName: "AppLogo"),
            Recipe.Instruction(description: "Heat frying pan", imageName: "AppLogo")
        ]),
        
        Recipe(title: "Recipe 2", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo")
        ]),
        
        Recipe(title: "Recipe 3", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo")
        ]),
        
        Recipe(title: "Recipe 4", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo")
        ]),
        
        Recipe(title: "Recipe 5", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo")
        ]),
        
        Recipe(title: "Recipe 6", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo")
        ]),
        
        Recipe(title: "Recipe 7", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo")
        ]),
        
        Recipe(title: "Recipe 8", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo")
        ]),
        
        Recipe(title: "Recipe 9", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo")
        ]),
        
        Recipe(title: "Recipe 10", imageName: "PestoPasta", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], instructions: [
            Recipe.Instruction(description: "Step1", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", imageName: "AppLogo")
        ])
    ]
}

    
    
