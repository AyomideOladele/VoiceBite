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
    @Environment(\.dismiss) var dismiss
    
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
                
                Spacer()
                    .frame(height: 100.0)
                
                Button {
                    dismiss()
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
    
    struct SignupScreenView_Previews: PreviewProvider {
        static var previews: some View {
            SignupScreenView()
        }
    }

