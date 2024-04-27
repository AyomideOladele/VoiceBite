//
//  SettingsView.swift
//  VoiceBite
//
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State private var chosenLanguage: String = "en-US"
    @EnvironmentObject var viewModel: AuthViewModel
       
    let languages = ["en-GB", "en-US", "en-AU"]
    
    var body: some View {
        //NavigationView{
            VStack{
                
                Text("SETTINGS")
                    .fontWeight(.bold)
                    .foregroundColor(Color("AccentColor"))
                    .padding(.vertical, 5.0)
                    .font(.title)
                
                List{
                    HStack{
                        SettingsBox(imageName: "mic.circle.fill", label: "Text To Speech Voice", iconColour: .secondary)
                        Spacer()
                        Picker("Select a language",
                               selection: $chosenLanguage) {
                            ForEach(languages, id: \.self) {
                                Text($0)
                            }
                        }.pickerStyle(.menu)
                            .onChange(of: chosenLanguage) { newLanguage in
                                Task {
                                    do {
                                        try await viewModel.updateUserPreferences(isDarkMode: isDarkMode, chosenLanguage: newLanguage)
                                    } catch {
                                        print("Error updating user preferences: \(error.localizedDescription)")
                                    }
                                }
                            }
                    }
                    
                    HStack{
                        SettingsBox(imageName: "moon", label: "Dark Mode", iconColour: .secondary)
                        Toggle("", isOn: $isDarkMode)
                            .onChange(of: isDarkMode)
                        { newValue in
                            Task {
                                do {
                                    try await viewModel.updateUserPreferences(isDarkMode: newValue, chosenLanguage: chosenLanguage)
                                } catch {
                                    print("Error updating user preferences: \(error.localizedDescription)")
                                }
                            }
                        }
                    }
                    
                    HStack{
                        SettingsBox(imageName: "questionmark.app", label: "Tutorial", iconColour: .secondary)
                        Spacer()
                        
                        NavigationLink {
                            TutorialView()
                        } label: {
                            Text("Check Voice Cmds")
                                .padding(.vertical, 10.0)
                                .padding(.horizontal, 10.0)
                                .font(.system(size: 15, weight: .bold))
                            
                        }.foregroundColor(Color("ButtonTextColor"))
                            .background(Color("AccentColor"))
                            .cornerRadius(15)
                            .frame(width: 190)
                    }
                }
            }//.padding(.top, -50)
            .onAppear {
                if let user = viewModel.currentUser {
                    isDarkMode = user.isDarkMode
                    chosenLanguage = user.chosenLanguage
                }
            }
        }
   // }
}

struct SettingsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(AuthViewModel())
    }
}


