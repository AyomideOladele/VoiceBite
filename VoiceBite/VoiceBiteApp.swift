//
//  VoiceBiteApp.swift
//  VoiceBite
//
//  Created by Ayomide Oladele on 19/02/2024.
//

import SwiftUI
import Firebase

@main
struct VoiceBiteApp: App {
    @StateObject var viewModel = AuthViewModel()
    @AppStorage("isDarkMode") private var isDarkMode = false
    //let persistenceController = PersistenceController.shared
    
    init(){
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .preferredColorScheme(isDarkMode ? .dark : .light)
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}