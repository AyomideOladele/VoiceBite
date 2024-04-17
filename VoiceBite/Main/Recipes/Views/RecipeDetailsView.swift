//
//  RecipeDetailsView.swift
//  VoiceBite
//
//  Created by Ayomide Oladele on 16/04/2024.
//

import SwiftUI

struct RecipeDetailsView: View {
    var recipe: Recipe
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    VStack{
                        Image(recipe.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 150)
                            .padding(18)
                            .shadow(color: Color.black.opacity(0.3), radius: 4, x:0, y:4)
                    }
                    .background(.ultraThinMaterial)
                    .cornerRadius(15)
                    .padding()
                    
                    Text(recipe.title)
                        .font(.title)
                        .bold()
                    
                    VStack (alignment: .leading){
                        VStack (alignment: .leading){
                            
                            Text("Ingredients")
                                .font(.title2)
                                .bold()
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: -10) {
                                    ForEach(Array(recipe.ingredients
                                        .enumerated()), id: \.element) {
                                            index, ingredient in
                                            Text(ingredient)
                                                .foregroundColor(Color("TextColour"))
                                                .padding(10)
                                                .background(.ultraThinMaterial)
                                                .cornerRadius(6)
                                        }.padding(.horizontal)
                                }
                            }.frame(height: 100)
                                .font(.body)
                                .foregroundColor(Color("TextColour"))
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding()
                        
                        VStack (alignment: .leading){
                            
                            Text("Instructions")
                                .font(.title2)
                                .bold()
                            
                            Text(recipe.instructions)
                                .font(.body)
                                .foregroundColor(Color("TextColour"))
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding()
                        
                    }.frame(width: .infinity, height: 500, alignment: .bottomLeading)
                        .background(.ultraThinMaterial)
                }
            }.navigationBarItems(trailing: Image(systemName: "xmark.circle").onTapGesture {
                dismiss()
            }
                .imageScale(.large)
                .foregroundColor(Color("TertiaryAccent"))
            )}
    }
}
struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailsView(recipe: Recipe(title: "Pesto Pasta", ingredients: ["1", "2"], instructions: "bla bla blah blah blah WOW", imageName: "PestoPasta"))
    }
}
