//
// LoginScreenView.swift
// VoiceBite
//
// A view for user login
//
// TODO: Current error message for invalid login is non specific, add specifc error message for wrong password, wrong email, and screen shake for when login details are incorrect

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack{
                
                // App Logo
                Image("AppLogo")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .padding(.top, 70)
                    .padding(.bottom, 40)
                    .accessibilityLabel("App Logo")
                
                // Welcome Text
                Text("Welcome Back!")
                    .foregroundColor(Color("AccentColor"))
                    .font(.title)
                
                // Form Fields
                VStack(spacing: 20){
                    InputBox(text: $email, placeholder: "Email")
                    .accessibilityLabel("Email")
                    InputBox(text: $password, placeholder: "Password", isSecureField: true)
                    .accessibilityLabel("Password")
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 25)
                
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
                .foregroundColor(Color("ButtonTextColor"))
                .background(Color("AccentColor"))
                .cornerRadius(15)
                .padding(.top, 40.0)
                // Displays alert if error occurs during authentication (i.e. email address already in use)
                // Gets error message if not nil in viewModel, sets it to nil after alert has been displayed
                .alert("Error", isPresented: Binding<Bool>(
                    get: { viewModel.errorMessage != nil },
                    set: { _ in viewModel.errorMessage = nil })) {
                        Button("OK", role: .cancel) { }
                    } message: {
                        Text(viewModel.errorMessage ?? "") // Displays error message and prevents app from crashing if errorMessage = nil by displaying empty string
                    }
                
                //Fade button if data entry from user is invalid
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.7)
                
                
                // Spaces login button away from navigation link
                Spacer(minLength: 20.0)
                
                // Navigates to signup page by adding it to the stack
                NavigationLink {
                    SignUpView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }.frame(maxHeight: .infinity)
                    .font(.body)
                    .accessibilityLabel("Naviagte to signup screen button")
                }
            }
        }
    }
}

// If user data entry is valid, returns true
extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        
        let emailFormatValid = email.contains("@") && email.contains(".")
        let passwordHasNumber = password.rangeOfCharacter(from: .decimalDigits) != nil
        let passwordHasCapitalLetter = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        let passwordLengthValid = password.count > 8
        
        return !email.isEmpty
        && emailFormatValid
        && !password.isEmpty
        && passwordLengthValid
        && passwordHasCapitalLetter
        && passwordHasNumber
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AuthViewModel())
    }
}
