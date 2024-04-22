//
//  AccountView.swift
//  VoiceBite
//
// A view displaying users account information, including options to sign out and delete account
//
// TODO: Add password reset functionality

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        if let user = viewModel.currentUser {
            NavigationStack{
                VStack{
                    
                    Text("MY ACCOUNT")
                        .fontWeight(.bold)
                        .foregroundColor(Color("AccentColor"))
                        .padding(.vertical, 5.0)
                        .font(.title)
                    
                    Text("Welcome Back, " + user.fullname)
                        .foregroundColor(Color("TextColor").opacity(0.8))
                        .font(.body)
                    
                    List {
                        Section("Details"){
                            
                            // Displays app version
                            HStack{
                                SettingsBox(imageName: "gear", label: "Version", iconColour: .secondary)
                                Spacer()
                                Text("1.0.0")
                            }.accessibilityLabel("Version 1.0.0")
                            
                            // Displays user's email
                            SettingsBox(imageName: "mail", label: user.email, iconColour: .secondary)
                                .accessibilityLabel("Email: \(user.email)")
                        }
                        
                        Section("Account"){
                            
                            // Reset password button
                            Button {
                                //TODO: viewModel.resetPassword()
                            } label: {
                                SettingsBox(imageName: "arrow.clockwise.circle.fill", label: "Reset Password", iconColour: .red)
                            }
                            .accessibilityLabel("Reset Password")
                            
                            // Sign Out Button
                            Button {
                                viewModel.signOut()
                            } label: {
                                SettingsBox(imageName: "arrow.left.circle.fill", label: "Sign Out", iconColour: .red)
                            }
                            .accessibilityLabel("Sign Out")
                            
                            // Delete Account Button
                            Button {
                                Task {
                                    await viewModel.deleteAccount()
                                }
                            } label: {
                                SettingsBox(imageName: "xmark.circle.fill", label: "Delete Account", iconColour: .red)
                            }
                            .accessibilityLabel("Delete Account")
                        }
                    }
                }
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView().environmentObject(AuthViewModel())
    }
}
