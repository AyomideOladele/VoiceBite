//
//  SignupScreenView.swift
//  VoiceBite
//
//  Created by Ayomide Oladele on 20/02/2024.
//

import SwiftUI

struct SignUpView: View {
    @State private var fullname = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
            VStack{
                
                // App Logo
                Image("AppLogo")
                    .resizable()
                    .frame(width : 120, height: 120)
                
                // Form Fields
                VStack(spacing: 24){
                    
                    InputBox(text: $fullname,
                              placeholder: "Full Name")
                    .autocapitalization(.none)
                    
                    InputBox(text: $email,
                              placeholder: "Email")
                    .autocapitalization(.none)
                    
                    InputBox(text: $password,
                              placeholder: "Password",
                              isSecureField: true)
                    
                    ZStack(alignment: .trailing) {
                        InputBox(text: $confirmPassword,
                                 placeholder: "Re-enter Password",
                                 isSecureField: true)
                        
                        // Displays checkmark to indicate to user whether passwords match or not
                        if !password.isEmpty && !confirmPassword.isEmpty{
                            if password == confirmPassword {
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGreen))
                            } else {
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemRed))
                            }
                        }
                    }
                    
                }
                .padding(.horizontal, 25)
                .padding(.top, 30)
                
                
                // Signup Button
                Button {
                    Task {
                        try await viewModel.createUser(withEmail: email, password:password, fullname:fullname)
                    }
                } label: {
                    Text("SIGNUP")
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
                
                // Spaces signup button away from navigation link
                Spacer()
                    .frame(height: 80.0)
                
                // Navigates to login page by pushing view off stack
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 3) {
                        Text("Already have an account?")
                        Text("Log in")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
            
        }
    }

extension SignUpView: AuthenticationFormProtocol {
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
        && confirmPassword == password
        && !fullname.isEmpty
        
    }
}
    
    struct SignupScreenView_Previews: PreviewProvider {
        static var previews: some View {
            SignUpView().environmentObject(AuthViewModel())
        }
    }

