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

    var body: some View {
        Group {
            if viewModel.userSession != nil {
                AccountView()
            } else {
                LoginScreenView()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
