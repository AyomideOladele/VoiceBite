//
//  AccountView.swift
//  VoiceBite
//
// A view displaying users account information, including options to sign out and delete account

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @State var showingAlert : Bool = false
    
    var body: some View {
        
        // Displays view only if there is a user currently logged in
        if let user = viewModel.currentUser {
                VStack{
                    
                    // Displays my account heading
                    Text("MY ACCOUNT")
                        .fontWeight(.bold)
                        .foregroundColor(Color("AccentColor"))
                        .padding(.vertical, 5.0)
                        .font(.title)
                    
                    // Displays welcome back text with current users full name
                    Text("Welcome Back, " + user.fullname)
                        .foregroundColor(Color("TextColor").opacity(0.8))
                        .font(.body)
                        .padding(.bottom, 20.0)
                    
                    List {
                        Section("Details"){
                            
                            // Displays user's email
                            SettingsBox(imageName: "mail", label: user.email, iconColour: .secondary)
                                .accessibilityLabel("Email: \(user.email)")
                        }
                        
                        Section("Help"){
                            
                            // Navigates user to tutorial if clicked
                            HStack{
                                SettingsBox(imageName: "questionmark.app", label: "Tutorial", iconColour: .secondary)
                                Spacer()
                                NavigationLink {
                                    TutorialView()
                                        
                                } label: {
                                    Text("Go")
                                        .padding(.vertical, 7.0)
                                        .padding(.horizontal, 7.0)
                                        .font(.system(size: 15, weight: .bold))
                                    
                                }.foregroundColor(Color("ButtonTextColor"))
                                    .background(Color("AccentColor"))
                                    .cornerRadius(15)
                                    .frame(width: 70, height: 10)
                            }
                        }
                        
                        Section("Account"){
                            
                            // Sign out button
                            Button {
                                viewModel.signOut()
                            } label: {
                                SettingsBox(imageName: "arrow.left.circle", label: "Sign Out", iconColour: Color("AccentColor"))
                            }
                            .accessibilityLabel("Sign Out")
                            
                            // Delete account button
                            Button {
                                showingAlert = true
                            } label: {
                                SettingsBox(imageName: "xmark.circle", label: "Delete Account", iconColour: Color("AccentColor"))
                            }
                            .accessibilityLabel("Delete Account")
                            // Displays alert to confirm account deletion
                            .alert(isPresented: $showingAlert) {
                                Alert(
                                    title: Text("Are you sure?"),
                                    message: Text("Permenantly delete your account? (This action cannot be reversed)"),
                                    primaryButton: .cancel(),
                                    secondaryButton: .destructive(Text("Delete"), action: {
                                        Task {
                                            await viewModel.deleteAccount() // Attempts to delete account
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

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView().environmentObject(AuthViewModel())
    }
}
