//
//  VoiceBiteApp.swift
//  VoiceBite
//
// Serves as the entry point for the VoiceBite application at startup.
// This file sets up the main application structure, initializes Firebase, and sets up the first view of the application.


import SwiftUI
import Firebase

@main
struct VoiceBiteApp: App {
    
    @StateObject var viewModel = AuthViewModel() // Authentication model for VoiceBite, used across the appliation
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    init(){
        FirebaseApp.configure()
    }

    // Configures and displays the first view of the app
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(viewModel) // Passes authentication model to first view
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
