//
//  RecipeCard.swift
//  VoiceBite
//
//  Created by Ayomide Oladele on 16/04/2024.
//

import SwiftUI

struct RecipeCard: View {
    var recipe: Recipe
    var body: some View {
        
        VStack(alignment: .leading){
            //Spacer()
            Image(recipe.imageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(15)
            
            Text(recipe.title)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(Color("TextColor"))
        }.frame(width:140, height:130)
        
        //VStack {
            //Image(recipe.imageName)
                //.resizable()
                //.scaledToFit()
                //.frame(maxHeight: 130)
                //.padding(10)
           // .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y:14)
        //}
        //.frame(maxWidth: .infinity, maxHeight: 200)
        //.background(.ultraThinMaterial)
        //.cornerRadius(15)
        
       // VStack(alignment: .leading, spacing: 7) {
          //  Text(recipe.title)
              //  .font(.title3).bold
            
            //Text(recipe.ingredients.joined(separator: ", "))
              //  .font(.subheadline)
              //  .foregroundColor(.gray)
               // .frame(width: 300, height: 40, alignment: .topLeading)
        //}
    }
}

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        
            let manager = RecipeManager()
            RecipeDetailsView(recipe: manager.recipes[0])
    }
}

//VStack(alignment: .leading){
    //Spacer()
        //.frame(width:140, height:130)
        //.background(Color.blue)
       // .cornerRadius(15)

    //Text("Recipe name")
        //.font(.system(size: 15, weight: .bold))
        //.foregroundColor(Color("TextColor")) }
