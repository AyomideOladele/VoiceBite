//
// LoginScreenView.swift
// VoiceBite
//
// A view for user login

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack{
                
                // Displays App logo
                Image("AppLogo")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .padding(.top, 70)
                    .padding(.bottom, 40)
                    .accessibilityLabel("App Logo")
                
                // Displays welcome text
                Text("Welcome Back!")
                    .foregroundColor(Color("AccentColor"))
                    .font(.title)
                
                // Displays form fields for user data entry
                VStack(spacing: 20){
                    InputBox(text: $email, placeholder: "Email")
                    .accessibilityLabel("Email")
                    InputBox(text: $password, placeholder: "Password", isSecureField: true)
                    .accessibilityLabel("Password")
                }
                .padding(.horizontal, 25)
                .padding(.vertical, 25)
                
                // Displays login Button - attempts to sign in users with details entered when clicked
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
                
                // Navigates to signup page by adding it to the navigation stack
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

// Checks if user data entry is valid
extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        // Regular expression pattern to check email is in correct format
        let emailRegex = "^[^@]+@[A-Za-z]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let emailFormatValid = emailPredicate.evaluate(with: email)
        
        // Checks password has at least one number, one capital letter and is over 8 characters
        let passwordHasNumber = password.rangeOfCharacter(from: .decimalDigits) != nil
        let passwordHasCapitalLetter = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        let passwordLengthValid = password.count >= 8
        
        // Returns true if all conditions are met
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
