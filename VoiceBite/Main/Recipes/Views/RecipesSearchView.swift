//
//  RecipesSearchView.swift
//  VoiceBite
//
//  Created by Ayomide Oladele on 15/04/2024.
//

import SwiftUI

struct RecipesSearchView: View {
    @ObservedObject var recipeManager: RecipeManager
    @State var selectedRecipe: Recipe? = nil
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum:100, maximum: 200)),
                    GridItem(.flexible(minimum:100, maximum: 200))
                ], spacing: 35, content: { // spacing inbetween rows
                    
                    ForEach(recipeManager.recipes) { recipe in
                        RecipeCard(recipe: recipe)
                            .onTapGesture {
                                selectedRecipe = recipe
                            }.fullScreenCover(item: $selectedRecipe) {selectedRecipe in
                                RecipeDetailsView(recipe: selectedRecipe)}
                }
                    
            }
        )} .padding(.horizontal, 15) // spacing at edges of page
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsScreenView()) {
                        Image(systemName: "gear")
                            .imageScale(.large)
                            .foregroundColor(Color("TertiaryAccent"))
                            .accessibilityLabel("App Settings")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AccountView()) {
                        Image(systemName: "person.circle")
                            .imageScale(.large)
                            .foregroundColor(Color("TertiaryAccent"))
                            .accessibilityLabel("Account")
                    }
                }
            }
                   
        }
    }
}


struct RecipesSearchView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesSearchView(recipeManager: RecipeManager())
    }
}
