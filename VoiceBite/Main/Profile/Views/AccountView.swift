//
//  AccountView.swift
//  VoiceBite
//
//  Created by Ayomide Oladele on 03/04/2024.
//

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
                    Text("Welcome back, " + user.fullname)
                        .foregroundColor(Color("TextColor").opacity(0.8))
                    
                    List {
                        Section("Details"){
                            HStack{
                                SettingsBox(imageName: "gear", label: "Version", iconColour: .secondary)
                                
                                Spacer()
                                
                                Text("1.0.0")
                            }
                            SettingsBox(imageName: "mail", label: user.email, iconColour: .secondary)
                            //SettingsBoxView(imageName: "key", title: User.MOCK_USER.password, tintColour: .secondary)
                            
                        }
                        
                        Section("Account"){
                            Button {
                                viewModel.signOut()
                            } label: {
                                SettingsBox(imageName: "arrow.left.circle.fill", label: "Sign Out", iconColour: .red)
                                }
                            
                            Button {
                                Task {
                                    await viewModel.deleteAccount()
                                }
                            } label: {
                                SettingsBox(imageName: "xmark.circle.fill", label: "Delete Account", iconColour: .red)
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
