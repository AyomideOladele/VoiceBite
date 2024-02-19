//
//  HomeScreenView.swift
//  VoiceBite
//
//  Created by Ayomide Oladele on 19/02/2024.
//

import SwiftUI

struct HomeScreenView: View {
    var body: some View {
        VStack{
            // App Logo
            Image("AppLogo")
                .resizable()
                .frame(width : 120, height: 120)
            
            // App Title
            Text("VOICEBITE")
                .foregroundColor(Color("AccentColor"))
                .padding(.bottom)
                .font(.system(size: 40))
            
            // Login Button
            Button(action: { }) {
                Text("Login")
                    .padding(.vertical, 12.0)
                    .padding(.horizontal, 48.0)
                    .font(.system(size: 20, weight: .bold))
            }
            .foregroundColor(Color("SecondaryAccent"))
            .background(Color("AccentColor"))
            .cornerRadius(15)
            .padding(.top, 100.0)
            
            // Signup button
            Button(action: { }) {
                Text("Signup")
                    .padding(.vertical, 12.0)
                    .padding(.horizontal, 40.0)
                    .font(.system(size: 20, weight: .bold))
            }
            .foregroundColor(Color("SecondaryAccent"))
            .background(Color("AccentColor"))
            .cornerRadius(15)
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
