//
//  RecipeDetailsView.swift
//  VoiceBite
//
// A view displaying recipe details as a full cover screen - start button begins recipe walkthrough

import SwiftUI

struct RecipeDetailsView: View {
    @ObservedObject var recipeManager: RecipeManager
    var recipe: Recipe
    @Environment(\.dismiss) var dismiss
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    
                    Text(recipe.title)
                        .font(.title)
                        .bold()
                    
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
                    //.padding()
                    
                    // Create the LazyVGrid
                    LazyVGrid(columns: gridItems, spacing: 20) {
                        // First column, first row
                        ForEach(recipe.recipeMetrics, id: \.self) {Metric in
                            VStack {
                                Text(Metric.detail)
                                    .font(.title3)  // Title font
                                    .fontWeight(.bold)
                                Text(Metric.label)
                                    .font(.caption)  // Caption font
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding()  // Add padding around the grid
                    
                    VStack (alignment: .leading){
                        VStack (alignment: .leading){
                            
                            Text("Ingredients")
                                .font(.title2)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: -10) {
                                    ForEach(Array(recipe.ingredients
                                        .enumerated()), id: \.element) {
                                            index, ingredient in
                                            Text(ingredient)
                                                .foregroundColor(Color("TextColor"))
                                                .padding(10)
                                                .background(.ultraThinMaterial)
                                                .cornerRadius(6)
                                        }.padding(.horizontal)
                                }
                            }.frame(height: 60)
                                .font(.body)
                                .foregroundColor(Color("TextColor"))
                        }
                        .padding([.top, .horizontal])
                        
                        VStack (alignment: .leading){
                            
                            Text("Utensils")
                                .font(.title2)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: -10) {
                                    ForEach(Array(recipe.utensils
                                        .enumerated()), id: \.element) {
                                            index, utensils in
                                            Text(utensils)
                                                .foregroundColor(Color("TextColor"))
                                                .padding(10)
                                                .background(.ultraThinMaterial)
                                                .cornerRadius(6)
                                        }.padding(.horizontal)
                                }
                            }.frame(height: 60)
                                .font(.body)
                                .foregroundColor(Color("TextColor"))
                        }
                        .padding([.top, .horizontal])
                        
                        VStack (alignment: .leading){
                            
                            Text("Instructions")
                                .font(.title2)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            LazyVStack (alignment: .leading){
                                ForEach(Array(recipe.instructions.enumerated()), id: \.element) { index, instruction in
                                    HStack{
                                        Text("\(index + 1))")
                                            .bold()
                                        Text ("\(instruction.description)")
                                    }
                                        .foregroundColor(Color("TextColor"))
                                        .padding(10)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                            }
                        }
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding()
                        
                        Text("Nutritional Information")
                            .font(.title2)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        HStack{
                            Text("Carbs:")
                            Text("\(recipe.nutritionalInfo[0])")
                                .bold()
                                .foregroundColor(Color("TextColor"))
                                .padding(10)
                        }.frame(maxWidth: .infinity, alignment: .center)
                        
                        HStack{
                            Text("Fats:")
                            Text("\(recipe.nutritionalInfo[1])")
                                .bold()
                                .foregroundColor(Color("TextColor"))
                                .padding(10)
                        }.frame(maxWidth: .infinity, alignment: .center)
                        
                        HStack{
                            Text("Proteins:")
                            Text("\(recipe.nutritionalInfo[2])")
                                .bold()
                                .foregroundColor(Color("TextColor"))
                                .padding(10)
                        }.frame(maxWidth: .infinity, alignment: .center)
                    }
                        VStack{
                            // Navigates to 1st recipe instruction by adding it to the stack
                            NavigationLink {
                                RecipeWalkthroughView(recipe: recipe)
                            } label: {
                                Text("START")
                                    .padding(.vertical, 12.0)
                                    .padding(.horizontal, 48.0)
                                    .font(.system(size: 20, weight: .bold))
                                
                            }.foregroundColor(Color("ButtonTextColor"))
                                .background(Color("AccentColor"))
                                .cornerRadius(15)
                            
                    }.padding([.top, .horizontal])
                }
            }
            .navigationBarItems(trailing: Image(systemName: "xmark.circle").onTapGesture {
                dismiss()
            }
            .imageScale(.large)
            .foregroundColor(Color("IconButtonColor"))
        )}
    }
}
struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        
        let manager = RecipeManager()
        RecipeDetailsView(recipeManager: RecipeManager(), recipe: manager.recipes[0])
    }
}
