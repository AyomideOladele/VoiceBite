//
//  SignUpView.swift
//  VoiceBite
//
// A view for user registration

import SwiftUI

struct SignUpView: View {
    
    @State private var fullname = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            
            Image("AppLogo")
                .resizable()
                .frame(width: 120, height: 120)
                .padding(.top, 70)
                .padding(.bottom, 20)
                .accessibilityLabel("App Logo")
            
            // Creates 4 vertical form fields
            VStack(spacing: 15){
                
                InputBox(text: $fullname, placeholder: "Full Name")
                    .accessibilityLabel("Full Name")
                InputBox(text: $email, placeholder: "Email")
                    .accessibilityLabel("Email")
                InputBox(text: $password, placeholder: "Password", isSecureField: true)
                    .accessibilityLabel("Password")
                
                // Displays checkmark overlay to user whether passwords match or not
                ZStack(alignment: .trailing) {
                    InputBox(text: $confirmPassword, placeholder: "Re-enter Password", isSecureField: true)
                        .accessibilityLabel("Confirm Password")
                    
                    if !password.isEmpty && !confirmPassword.isEmpty{
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle")
                                .imageScale(.large)
                                .foregroundColor(.green)
                                .opacity(0.8)
                                .offset(x: -8)
                        } else {
                            Image(systemName: "xmark.circle")
                                .imageScale(.large)
                                .foregroundColor(.red)
                                .opacity(0.8)
                                .offset(x: -8)
                        }
                    }
                }
                
                Text("Password must be at least 8 characters, contain at least 1 uppercase letter and 1 numeric character")
                .font(.caption2)
                .italic()
                .foregroundColor(Color("TextColor"))
                .fixedSize(horizontal: false, vertical: true) // Wraps text around
                
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 25)
            
            
            // Signup Button
            Button {
                Task {
                    try await viewModel.createUser(withEmail: email, password:password, fullname:fullname) // if successful, dismisses sign up view and displays recipe directory on users new account
                }
            } label: {
                Text("SIGNUP")
                    .padding(.vertical, 12.0)
                    .padding(.horizontal, 48.0)
                    .font(.system(size: 20, weight: .bold))
            }
            .foregroundColor(Color("ButtonTextColor"))
            .background(Color("AccentColor"))
            .cornerRadius(15)
            .padding(.top, 40.0)
            .accessibilityLabel("Signup button")
            
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
            
            // Spaces signup button away from navigation link
            Spacer(minLength: 20.0)
            
            // Navigates to login page by pushing view off stack
            Button {
                dismiss()
                } label: {
                    HStack(spacing: 3) {
                        Text("Already have an account?")
                        Text("Log in")
                            .fontWeight(.bold)
                    }.font(.body)
                }.frame(maxHeight: .infinity)
                 .accessibilityLabel("Navigate to login screen")
            }
        }
}

// If user data entry is valid, returns true
extension SignUpView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        // Define the regex pattern to check the email format
        let emailRegex = "^[^@]+@[A-Za-z]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let emailFormatValid = emailPredicate.evaluate(with: email)
        
        //let emailFormatValid = email.contains("@") && email.contains(".")
        let passwordHasNumber = password.rangeOfCharacter(from: .decimalDigits) != nil
        let passwordHasCapitalLetter = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        let passwordLengthValid = password.count >= 8
        
        return !email.isEmpty
        && emailFormatValid
        && !password.isEmpty
        && passwordLengthValid
        && passwordHasCapitalLetter
        && passwordHasNumber
        && confirmPassword == password
        && !fullname.isEmpty
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(AuthViewModel())
    }
}
