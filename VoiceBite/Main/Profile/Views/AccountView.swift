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
    @State var showingAlert : Bool = false
    
    var body: some View {
        
        if let user = viewModel.currentUser {
            NavigationView{
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
                            
                            /*
                            // Reset password button
                            Button {
                                //TODO: viewModel.resetPassword()
                            } label: {
                                SettingsBox(imageName: "arrow.clockwise.circle.fill", label: "Reset Password", iconColour: .red)
                            }
                            .accessibilityLabel("Reset Password")*/
                            
                            // Sign Out Button
                            Button {
                                viewModel.signOut()
                            } label: {
                                SettingsBox(imageName: "arrow.left.circle.fill", label: "Sign Out", iconColour: .red)
                            }
                            .accessibilityLabel("Sign Out")
                            
                            // Delete Account Button
                            Button {
                                showingAlert = true
                            } label: {
                                SettingsBox(imageName: "xmark.circle.fill", label: "Delete Account", iconColour: .red)
                            }
                            .accessibilityLabel("Delete Account")
                            // Displays alert if error occurs during authentication (i.e. email address already in use)
                            // Gets error message if not nil in viewModel, sets it to nil after alert has been displayed
                            .alert(isPresented: $showingAlert) {
                                Alert(
                                    title: Text("Are you sure?"),
                                    message: Text("Permenantly delete your account? (This action cannot be reversed)"),
                                    primaryButton: .cancel(),
                                    secondaryButton: .destructive(Text("Delete"), action: {
                                        Task {
                                            await viewModel.deleteAccount()
                                        }
                                    })
                                )
                            }
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
