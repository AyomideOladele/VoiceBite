//
//  ContentView.swift
//  VoiceBite
//
//  Created by Ayomide Oladele on 19/02/2024.
//

import SwiftUI
//import CoreData

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    //@EnvironmentObject var appSettingsModel: AppSettingsModel
    

    var body: some View {
        Group {
            
            // Displays recipe search if user is logged in
            if viewModel.userSession != nil {
                RecipesDirectoryView(recipeManager: RecipeManager())
                
            // Otherwise, displays login screen
            } else {
                LoginView()
            }
        }//.preferredColorScheme(appSettingsModel.isDarkMode ? .dark : .light)
    }
    

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
