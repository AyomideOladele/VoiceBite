//
//  SplashScreenView.swift
//  VoiceBite
//
//  Created by Ayomide Oladele on 19/02/2024.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        
        // App Logo
        Image("AppLogo")
            .resizable()
            .frame(width : 250, height: 250)
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
