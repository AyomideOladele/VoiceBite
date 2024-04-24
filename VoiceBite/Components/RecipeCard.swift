//
//  RecipeCard.swift
//  VoiceBite
//
// A reusuable view component for recipes on the directory view. Formats recipe image into a rounded and displays title + background banner as an overlay.

import SwiftUI

struct RecipeCard: View {
    
    var recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading){
            
            // Resizes recipe image into a rounded square
            Image(recipe.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .clipped()
                .cornerRadius(25)
                // Creates banner at top of image, with recipe title
                .overlay(
                    Text(recipe.title)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(Color("ButtonTextColor"))
                        .frame(width: 120)
                        .background(Color.black.opacity(0.5))
                        .offset(y: 20), alignment: .topLeading
                        
                )
        }
    }
}

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        let manager = RecipeManager()
        RecipeCard(recipe: manager.recipes[0])
    }
}
