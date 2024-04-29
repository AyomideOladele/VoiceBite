//
//  SettingsView.swift
//  VoiceBite
//
// A view that provides an interface for users to adjust their language preference and dark mode.

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State private var chosenLanguage: String = "en-US"
    @EnvironmentObject var viewModel: AuthViewModel
    let languages = ["en-GB", "en-US", "en-AU"]
    
    var body: some View {
            VStack{
                
                // Displays settings title
                Text("SETTINGS")
                    .fontWeight(.bold)
                    .foregroundColor(Color("AccentColor"))
                    .padding(.vertical, 5.0)
                    .font(.title)
                
                List{
                    // User interface for choosing text-to-speech language
                    HStack{
                        SettingsBox(imageName: "mic.circle.fill", label: "Text To Speech Voice", iconColour: .secondary)
                        Spacer()
                        Picker("Select a language",
                               selection: $chosenLanguage) {
                            ForEach(languages, id: \.self) {
                                Text($0)
                            }
                        }.pickerStyle(.menu)
                           // Checks if the user has changed value of picker, if so attempts to update user preferences
                            .onChange(of: chosenLanguage) { newLanguage in
                                Task {
                                    do {
                                        try await viewModel.updateUserPreferences(isDarkMode: isDarkMode, chosenLanguage: newLanguage)
                                    } catch {
                                        print("DEBUG: Error updating user preferences: \(error.localizedDescription)")
                                    }
                                }
                            }
                    }
                    
                    // User interface toggle for choosing colour scheme, dark mode or light mode
                    HStack{
                        SettingsBox(imageName: "moon", label: "Dark Mode", iconColour: .secondary)
                        Toggle("", isOn: $isDarkMode)
                            // Checks if the user has switched the toggle, if so attempts to updates preferences
                            .onChange(of: isDarkMode)
                        { newValue in
                            Task {
                                do {
                                    try await viewModel.updateUserPreferences(isDarkMode: newValue, chosenLanguage: chosenLanguage)
                                } catch {
                                    print("DEBUG: Error updating user preferences: \(error.localizedDescription)")
                                }
                            }
                        }
                    }
                }
            } // Checks if there's a user session, then sets the settings to their preferences
            .onAppear {
                if let user = viewModel.currentUser {
                    isDarkMode = user.isDarkMode
                    chosenLanguage = user.chosenLanguage
                }
            }
        }
}

struct SettingsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(AuthViewModel())
    }
}


