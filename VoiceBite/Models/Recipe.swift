//
//  Recipe.swift
//  VoiceBite
//
// A model for a recipe

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

// Database of recipes
class RecipeManager: ObservableObject {
    
    @Published var recipes: [Recipe] = [
        
        Recipe(title: "Pesto Pasta", imageName: "PestoPasta", ingredients: ["200g Pasta", "2 Garlic Cloves", "40g Basil Leaves", "25g Pine Nuts", "25g Grated Parmesan Cheese", "75ml Olive Oil", "Black Pepper", "Salt"], utensils: ["Medium Pot", "Food Processor", "Strainer", "Small Bowl"], nutritionalInfo: ["40g", "9g", "1g"],
            instructions: [
            Recipe.Instruction(description: "Prepare Pesto", details: ["a) Put basil, pine nuts, garlic and 3/4 of the parmesean into food processor and pulse until finely chopped", "b) While the food processor is running, slowly combine olive oil until fully combined", "c) Continue pulsing until mixture is smooth"], imageName: "MixingPesto"),
            Recipe.Instruction(description: "Cook Pasta", details: ["a) Fill pot with water, add a pinch of salt and bring to boil", "b) Add pasta and cook for 10 to 12 minutes until al dente", "c) Once cooked, drain pasta and reserve 250ml of pasta water"], imageName: "BoilingPotWater"),
            Recipe.Instruction(description: "Combine Pesto and Pasta", details: ["a) Return the pasta to the pot", "b) Add pasta water and pesto to pot and mix well"], imageName: "PestoPasta"),
            Recipe.Instruction(description: "Recipe Complete!", details: ["Serve pasta into two bowls, add parmesean cheese and black pepper to taste, and enjoy!"], imageName: "PestoPasta")],
            recipeMetrics: [
            Recipe.Metric(detail: "5 mins", label: "Preperation Time"),
            Recipe.Metric(detail: "375 kcal", label: "Calories Per Serving"),
            Recipe.Metric(detail: "12 min", label: "Cooking Time"),
            Recipe.Metric(detail: "2", label: "Servings")
            ]),
        
        Recipe(title: "Simple Cheesy Omlette", imageName: "BasicOmlette", ingredients: ["3 Large Eggs", "1 tsbp of Sunflower Oil", "1tsp of Butter", "20g Cheese", "Salt", "Black Pepper"], utensils: ["Non-stick frying pan", "Mixing bowl", "Spatula", "Whisk"],
            nutritionalInfo: ["0g", "22g", "20g"],
            instructions: [
            Recipe.Instruction(description: "Beat the eggs", details:["a) Crack eggs and add to mixing bowl", "b) Whisk until egg white and yolk are combined", "c) Season mixture with a pinch of salt and a pinch of pepper"], imageName: "EggCracked"),
            Recipe.Instruction(description: "Cook the eggs", details:["a) Heat the oil and butter in a non-stick frying pan over a medium-low heat until melted and foaming", "b) Pour eggs into pan, tilting it slightly from one side to another to cover the surface of the pan completely", "c) Let it sit for 20 seconds"], imageName: "EggInPan"),
            Recipe.Instruction(description: "Continue cooking the eggs", details:["a)Scrape a line through the middle of the omlette with a spatula", "b) Tilt the pan again to let the slit fill with runny egg", "c) Repeat once or twice more until egg has just set"], imageName: "EggInPan"),
            Recipe.Instruction(description: "Add Cheese", details:["a) Sprinkle cheese and ham on top of omlette", "b) Fold the omlette gently with a spatula"], imageName: "BasicOmlette"),
            Recipe.Instruction(description: "Recipe Complete!", details:["Serve on a plate, season to your likeing, and enjoy!"], imageName: "BasicOmlette")],
               recipeMetrics: [
               Recipe.Metric(detail: "5 mins", label: "Preperation Time"),
               Recipe.Metric(detail: "300 kcal", label: "Calories Per Serving"),
               Recipe.Metric(detail: "5 min", label: "Cooking Time"),
               Recipe.Metric(detail: "1", label: "Serving")
           ]),
        
        Recipe(title: "Easy Pancakes", imageName: "Pancakes", ingredients: ["100g Plain Flour", "2 Large Eggs", "300ml Milk", "1 tbsp Sunflower Oil", "Lemons", "Caster Sugar"], utensils: ["Bowl", "Non-stick frying pan", "Ladel", "Spatula", "Whisk", "Kitchen Towel"],
               nutritionalInfo: ["84g", "24g", "36g"],
               instructions: [
            Recipe.Instruction(description: "Mix Ingredients", details:[" a) Combine flour, eggs, oil and a pinch of salt in the bowl", "b) Whisk into a smooth batter"], imageName: "Pancakes"),
            Recipe.Instruction(description: "Cook Pancakes", details:["a) Heat frying pan on a medium heat and carefully wipe with an oiled kitchen towel", "b) When hot add a ladelful of your pancake batter", "c) Cook pancake on each side for 1 minute until golden, remove with spatula when done"], imageName: "Pancakes"),
            Recipe.Instruction(description: "Add Extras", details:["a) Slice up lemon into wedges", "b) Squeeze lemon juice onto pancakes", "c) Sprinkle caster sugar onto pancakes"], imageName: "Pancakes"),
            Recipe.Instruction(description: "Recipe Complete!", details:["Serve pancakes onto plates and enjoy!"], imageName: "Pancakes")],
               recipeMetrics: [
               Recipe.Metric(detail: "10 mins", label: "Preperation Time"),
               Recipe.Metric(detail: "244 kcal", label: "Calories Per Serving"),
               Recipe.Metric(detail: "20 mins", label: "Cooking Time"),
               Recipe.Metric(detail: "3", label: "Servings")
           ]),
        
        Recipe(title: "Recipe 4", imageName: "AppLogo", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], utensils: ["Utensil 1", "Utensil 2", "Utensil 3"],
               nutritionalInfo: ["0g", "0g", "0g"],
               instructions: [
            Recipe.Instruction(description: "Step1", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo")],
               recipeMetrics: [
               Recipe.Metric(detail: "0 mins", label: "Preperation Time"),
               Recipe.Metric(detail: "0 kcal", label: "Calories Per Serving"),
               Recipe.Metric(detail: "0 mins", label: "Cooking Time"),
               Recipe.Metric(detail: "0", label: "Servings")
           ]),
        Recipe(title: "Recipe 5", imageName: "AppLogo", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], utensils: ["Utensil 1", "Utensil 2", "Utensil 3"],
               nutritionalInfo: ["0g", "0g", "0g"],
               instructions: [
            Recipe.Instruction(description: "Step1", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo")],
               recipeMetrics: [
               Recipe.Metric(detail: "0 mins", label: "Preperation Time"),
               Recipe.Metric(detail: "0 kcal", label: "Calories Per Serving"),
               Recipe.Metric(detail: "0 mins", label: "Cooking Time"),
               Recipe.Metric(detail: "0", label: "Servings")
           ]),
        Recipe(title: "Recipe 6", imageName: "AppLogo", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], utensils: ["Utensil 1", "Utensil 2", "Utensil 3"],
               nutritionalInfo: ["0g", "0g", "0g"],
               instructions: [
            Recipe.Instruction(description: "Step1", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo")],
               recipeMetrics: [
               Recipe.Metric(detail: "0 mins", label: "Preperation Time"),
               Recipe.Metric(detail: "0 kcal", label: "Calories Per Serving"),
               Recipe.Metric(detail: "0 mins", label: "Cooking Time"),
               Recipe.Metric(detail: "0", label: "Servings")
           ]),
        Recipe(title: "Recipe 7", imageName: "AppLogo", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], utensils: ["Utensil 1", "Utensil 2", "Utensil 3"],
               nutritionalInfo: ["0g", "0g", "0g"],
               instructions: [
            Recipe.Instruction(description: "Step1", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo")],
               recipeMetrics: [
               Recipe.Metric(detail: "0 mins", label: "Preperation Time"),
               Recipe.Metric(detail: "0 kcal", label: "Calories Per Serving"),
               Recipe.Metric(detail: "0 mins", label: "Cooking Time"),
               Recipe.Metric(detail: "0", label: "Servings")
           ]),
        Recipe(title: "Recipe 8", imageName: "AppLogo", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], utensils: ["Utensil 1", "Utensil 2", "Utensil 3"],
               nutritionalInfo: ["0g", "0g", "0g"],
               instructions: [
            Recipe.Instruction(description: "Step1", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo")],
               recipeMetrics: [
               Recipe.Metric(detail: "0 mins", label: "Preperation Time"),
               Recipe.Metric(detail: "0 kcal", label: "Calories Per Serving"),
               Recipe.Metric(detail: "0 mins", label: "Cooking Time"),
               Recipe.Metric(detail: "0", label: "Servings")
           ]),
        Recipe(title: "Recipe 9", imageName: "AppLogo", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], utensils: ["Utensil 1", "Utensil 2", "Utensil 3"],
               nutritionalInfo: ["0g", "0g", "0g"],
               instructions: [
            Recipe.Instruction(description: "Step1", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo")],
               recipeMetrics: [
               Recipe.Metric(detail: "0 mins", label: "Preperation Time"),
               Recipe.Metric(detail: "0 kcal", label: "Calories Per Serving"),
               Recipe.Metric(detail: "0 mins", label: "Cooking Time"),
               Recipe.Metric(detail: "0", label: "Servings")
           ]),
        Recipe(title: "Recipe 10", imageName: "AppLogo", ingredients: ["Ingredient1", "Ingredient2", "Ingredient3"], utensils: ["Utensil 1", "Utensil 2", "Utensil 3"],
               nutritionalInfo: ["0g", "0g", "0g"],
               instructions: [
            Recipe.Instruction(description: "Step1", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step2", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo"),
            Recipe.Instruction(description: "Step3", details:["Detail1", "Detail2", "Detail3"], imageName: "AppLogo")],
               recipeMetrics: [
               Recipe.Metric(detail: "0 mins", label: "Preperation Time"),
               Recipe.Metric(detail: "0 kcal", label: "Calories Per Serving"),
               Recipe.Metric(detail: "0 mins", label: "Cooking Time"),
               Recipe.Metric(detail: "0", label: "Servings")
           ])
    ]
}

    
    
