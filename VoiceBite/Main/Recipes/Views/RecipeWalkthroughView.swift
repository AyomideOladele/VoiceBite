//
//  RecipeStepView.swift
//  VoiceBite
//
//  Created by Ayomide Oladele on 17/04/2024.
//

import SwiftUI

struct RecipeWalkthroughView: View {
    var recipe: Recipe
    @Environment(\.dismiss) var dismiss
    var body: some View {
                TabView {
                    ForEach(recipe.instructions.indices, id: \.self) { index in
                        VStack {
                            Image(recipe.instructions[index].imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 150)
                                .padding(18)
                                .shadow(color: Color.black.opacity(0.3), radius: 4, x:0, y:4)
                                .padding()
                            
                            Image(systemName: "\(index + 1).circle.fill")
                                .imageScale(.large)
                            
                            Text(recipe.instructions[index].description)
                                .padding()
                        }
                    }
                    
                }.tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                }
            }

struct RecipeStepView_Previews: PreviewProvider {
    static var previews: some View {
        
        let manager = RecipeManager()
        RecipeDetailsView(recipe: manager.recipes[0])
    }
}
