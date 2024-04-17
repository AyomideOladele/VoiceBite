//
//  RecipeStepView.swift
//  VoiceBite
//
//  Created by Ayomide Oladele on 17/04/2024.
//

import SwiftUI

struct RecipeStepView: View {
    var recipe: Recipe
    @Environment(\.dismiss) var dismiss
    var body: some View {
                TabView {
                    ForEach(recipe.instructions.indices, id: \.self) { index in
                        VStack {
                            Image(recipe.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 150)
                                .padding(18)
                                .shadow(color: Color.black.opacity(0.3), radius: 4, x:0, y:4)
                            
                            
                                .background(.ultraThinMaterial)
                                .padding()
                            
                            Image(systemName: "\(index + 1).circle.fill")
                                .imageScale(.large)
                            
                            Text(recipe.instructions[index])
                                .padding()
                        }
                    }
                    
                }.tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                }
            }

struct RecipeStepView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeStepView(recipe: Recipe(title: "Pesto Pasta", ingredients: ["Penne Pasta", "Pesto", "Oil"], instructions: ["Boil a pan of water with salt", "Add pasta to water", "Heat frying pan"], imageName: "PestoPasta"))
    }
}
