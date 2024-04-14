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
                        .foregroundColor(Color("QuaternaryAccent"))
                    
                    List {
                        Section("Details"){
                            HStack{
                                SettingsBoxView(imageName: "gear", title: "Version", tintColour: .secondary)
                                
                                Spacer()
                                
                                Text("1.0.0")
                            }
                            SettingsBoxView(imageName: "mail", title: user.email, tintColour: .secondary)
                            //SettingsBoxView(imageName: "key", title: User.MOCK_USER.password, tintColour: .secondary)
                            
                        }
                        
                        Section("Account"){
                            Button {
                                viewModel.signOut()
                            } label: {
                                SettingsBoxView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColour: .red)
                                }
                            
                            Button {
                                print("Delete Account...")
                            } label: {
                                SettingsBoxView(imageName: "xmark.circle.fill", title: "Delete Account", tintColour: .red)
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
        AccountView()
    }
}
