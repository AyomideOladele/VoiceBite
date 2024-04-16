//
//  Recipe.swift
//  VoiceBite
//
//  Created by Ayomide Oladele on 15/04/2024.
//

import Foundation

struct Recipe: Identifiable, Codable{
    var id = UUID()
    var title: String
    var ingredients: [String]
    var instructions: String
    var imageName: String
    //var image: UIImage? { get set }
    
    // Retrieves users initals from their full name, returns empty string if invalid
    //var getFullRecipe: String
    
    // Retrieves users initals from their full name, returns empty string if invalid
    //var displayDetails: String
    
    // Retrieves users initals from their full name, returns empty string if invalid
    //var startRecipe: String
    
}

// Development goal: Link with Firebase
class RecipeManager: ObservableObject {
    
    @Published var recipes: [Recipe] = [
        
        Recipe(title: "Pesto Pasta", ingredients: ["1", "2"], instructions: "bla bla blah blah blah WOW", imageName: "PestoPasta"),
        
        Recipe(title: "RecipeTitle 2", ingredients: ["1", "2"], instructions: "bla bla blah blah blah WOW", imageName: "AppLogo"),
        
        Recipe(title: "RecipeTitle 3", ingredients: ["1", "2"], instructions: "bla bla blah blah blah WOW", imageName: "AppLogo"),
        
        Recipe(title: "RecipeTitle 4", ingredients: ["1", "2"], instructions: "bla bla blah blah blah WOW", imageName: "AppLogo"),
        
        Recipe(title: "RecipeTitle 5", ingredients: ["1", "2"], instructions: "bla bla blah blah blah WOW", imageName: "AppLogo"),
        
        Recipe(title: "RecipeTitle 6", ingredients: ["1", "2"], instructions: "bla bla blah blah blah WOW", imageName: "AppLogo"),
        
        Recipe(title: "RecipeTitle 7", ingredients: ["1", "2"], instructions: "bla bla blah blah blah WOW", imageName: "AppLogo"),
        
        Recipe(title: "RecipeTitle 8", ingredients: ["1", "2"], instructions: "bla bla blah blah blah WOW", imageName: "AppLogo"),
        
        Recipe(title: "RecipeTitle 9", ingredients: ["1", "2"], instructions: "bla bla blah blah blah WOW", imageName: "AppLogo"),
        
        Recipe(title: "RecipeTitle 10", ingredients: ["1", "2"], instructions: "bla bla blah blah blah WOW", imageName: "AppLogo")
    ]
}

    
    
