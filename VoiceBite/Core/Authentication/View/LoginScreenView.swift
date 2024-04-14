//  LoginScreenView.swift
//  VoiceBite
//  Created by Ayomide Oladele on 19/02/2024.

import SwiftUI

struct LoginScreenView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
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
                Button {
                    Task {
                       try await viewModel.signIn(withEmail: email, password: password)
                  }
                    
                } label: {
                    Text("LOGIN")
                        .padding(.vertical, 12.0)
                        .padding(.horizontal, 48.0)
                        .font(.system(size: 20, weight: .bold))
                }
                .foregroundColor(Color("SecondaryAccent"))
                .background(Color("AccentColor"))
                .cornerRadius(15)
                .padding(.top, 50.0)
                
                //Fade button if data entry from user is invalid
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                
                
                // Spaces login button away from navigation link
                Spacer()
                    .frame(height: 100.0)
                
                // Navigates to signup page by adding it to the stack
                NavigationLink {
                    SignupScreenView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
            
        }
    }
    
}

extension LoginScreenView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        
        let emailHasBasicFormat = email.contains("@") && email.contains(".")
        let passwordHasNumber = password.rangeOfCharacter(from: .decimalDigits) != nil
        let passwordHasCapitalLetter = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        let passwordLengthValid = password.count > 8
        
        return !email.isEmpty
        && emailHasBasicFormat
        && !password.isEmpty
        && passwordLengthValid
        && passwordHasCapitalLetter
        && passwordHasNumber
        
    }
}

struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView().environmentObject(AuthViewModel())
    }
}
