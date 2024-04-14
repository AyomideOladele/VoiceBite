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
    //let persistenceController = PersistenceController.shared
    
    init(){
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
