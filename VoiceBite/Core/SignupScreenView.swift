//
//  SignupScreenView.swift
//  VoiceBite
//
//  Created by Ayomide Oladele on 20/02/2024.
//

import SwiftUI

struct SignupScreenView: View {
        @State private var name = ""
        @State private var email = ""
        @State private var password = ""
    
    var body: some View {
            VStack{
                
                // App Logo
                Image("AppLogo")
                    .resizable()
                    .frame(width : 120, height: 120)
                
                // Form Fields
                VStack(spacing: 24){
                    
                    InputView(text: $name,
                              placeholder: "Name")
                    .autocapitalization(.none)
                    
                    InputView(text: $email,
                              placeholder: "Email")
                    .autocapitalization(.none)
                    
                    InputView(text: $password,
                              placeholder: "Password",
                              isSecureField: true)
                    InputView(text: $password,
                              placeholder: "Re-enter Password",
                              isSecureField: true)
                    
                }
                .padding(.horizontal, 25)
                .padding(.top, 30)
                
                
                // Signup Button
                Button(action: { }) {
                    Text("SIGNUP")
                        .padding(.vertical, 12.0)
                        .padding(.horizontal, 48.0)
                        .font(.system(size: 20, weight: .bold))
                }
                .foregroundColor(Color("SecondaryAccent"))
                .background(Color("AccentColor"))
                .cornerRadius(15)
                .padding(.top, 50.0)
                
                // Back Button
                Button(action: { }) {
                    Text("BACK")
                        .padding(.vertical, 12.0)
                        .padding(.horizontal, 20.0)
                        .font(.system(size: 20, weight: .bold))
                }
                .foregroundColor(Color("SecondaryAccent"))
                .background(Color("TertiaryAccent"))
                .cornerRadius(15)
                .padding(.top, 100.0)
            }
    }
}


struct SignupScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignupScreenView()
    }
}
