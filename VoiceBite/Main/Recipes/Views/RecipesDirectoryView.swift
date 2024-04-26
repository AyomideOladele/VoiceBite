//
//  RecipesSearchView.swift
//  VoiceBite
//
//  A view displaying all recipes in Recipe Manager in a grid view
//

import SwiftUI

struct RecipesDirectoryView: View {
    @ObservedObject var recipeManager: RecipeManager
    @State var selectedRecipe: Recipe? = nil
    @State var searchTerm = ""
    @State var isSearching = false
    var body: some View {
        NavigationView {
            ScrollView {
                HStack {
                    HStack{
                        TextField("Search here", text: $searchTerm)
                            .padding(.leading, 24)
                    } .padding().background(Color("LightGray"))
                        .cornerRadius(6)
                        .padding(.horizontal)
                        .frame(width: 250, height: 80)
                        .onTapGesture(perform: {
                            isSearching = true
                        })
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                Spacer()
                                
                                if isSearching {
                                    Button(action: { searchTerm = ""
                                        
                                    }, label: {
                                        Image(systemName: "xmark.circle")
                                            .padding(.vertical)
                                    })
                                    
                                }
                                
                            }.padding(.horizontal, 32)
                            .foregroundColor(Color("TextColor"))
                        ).transition(.move(edge: .trailing))
                        .animation(Animation.spring(), value:0)
                    
                    if isSearching{
                        Button(action: {
                            isSearching = false
                            searchTerm = ""
                            
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            
                        }, label: {
                            Text("Cancel")
                                .padding(.trailing)
                                .padding(.leading, 0)
                            
                        })
                        .transition(.move(edge: .trailing))
                        .animation(Animation.spring(), value:2)
                    }
                }.frame(height: 80)
                
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum:100, maximum: 200)),
                    GridItem(.flexible(minimum:100, maximum: 200))
                ], spacing: 35, content: { // spacing inbetween rows
                    
                    ForEach(recipeManager.recipes.filter({"\($0)".contains(searchTerm) || searchTerm.isEmpty})) { recipe in
                        RecipeCard(recipe: recipe)
                            .onTapGesture {
                                selectedRecipe = recipe
                            }.fullScreenCover(item: $selectedRecipe) {selectedRecipe in
                                RecipeDetailsView(recipeManager: RecipeManager(), recipe: selectedRecipe)}
                        
                    }
                    
            }
        )} .padding(.horizontal, 15) // spacing at edges of page
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                            .imageScale(.large)
                            .foregroundColor(Color("IconButtonColor"))
                            .accessibilityLabel("App Settings")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AccountView()) {
                        Image(systemName: "person.circle")
                            .imageScale(.large)
                            .foregroundColor(Color("IconButtonColor"))
                            .accessibilityLabel("Account")
                    }
                }
            }
                   
        }
    }
}


struct RecipesSearchView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesDirectoryView(recipeManager: RecipeManager())
    }
}
