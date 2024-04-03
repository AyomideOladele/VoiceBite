//  LoginScreenView.swift
//  VoiceBite
//  Created by Ayomide Oladele on 19/02/2024.

import SwiftUI

struct LoginScreenView: View {
    @State private var email = ""
    @State private var password = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack{
                
                // App Logo
                Image("AppLogo")
                    .resizable()
                    .frame(width : 120, height: 120)
                
                // Welcome Text
                Text("Welcome Back!")
                    .foregroundColor(Color("AccentColor"))
                    .padding(.top, 35.0)
                    .font(.system(size: 30))
                
                // Form Fields
                VStack(spacing: 24){
                    InputView(text: $email,
                              placeholder: "Email")
                    .autocapitalization(.none)
                    
                    InputView(text: $password,
                              placeholder: "Password",
                              isSecureField: true)
                    
                }
                .padding(.horizontal, 25)
                .padding(.top, 30)
                
                
                // Login Button
                Button(action: { }) {
                    Text("LOGIN")
                        .padding(.vertical, 12.0)
                        .padding(.horizontal, 48.0)
                        .font(.system(size: 20, weight: .bold))
                }
                .foregroundColor(Color("SecondaryAccent"))
                .background(Color("AccentColor"))
                .cornerRadius(15)
                .padding(.top, 50.0)
                
                //Spacer()
                
                Spacer()
                    .frame(height: 100.0)
                
                //Button {
                //dismiss()
                NavigationLink {
                    SignupScreenView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Already have an account?")
                        Text("Sign in")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
            
            
        }
    }
    
    struct LoginScreenView_Previews: PreviewProvider {
        static var previews: some View {
            LoginScreenView()
        }
    }
}
