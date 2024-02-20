//
//  VoiceBiteApp.swift
//  VoiceBite
//
//  Created by Ayomide Oladele on 19/02/2024.
//

import SwiftUI

@main
struct VoiceBiteApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
