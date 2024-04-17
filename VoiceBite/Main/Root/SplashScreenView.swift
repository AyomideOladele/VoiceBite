//
//  SplashScreenView.swift
//  VoiceBite
//
//  Created by Ayomide Oladele on 19/02/2024.
//

import SwiftUI

struct SplashScreenView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isActive = false;
    @State private var size = 0.5
    @State private var opacity = 0.3
    var body: some View {
        
        if isActive {
            ContentView().environmentObject(viewModel)
        } else {
            VStack{
                VStack{
                    // App Logo
                    Image("AppLogo")
                        .resizable()
                        .frame(width : 150, height: 150)
                    
                    // App Title
                    Text("VoiceBite")
                        .foregroundColor(Color("TextColour").opacity(0.80))
                        .font(.system(size: 40))
                        .bold()
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    // Development Note: Turn into pulsating animation
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.7
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
            
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
