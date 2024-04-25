//
//  SettingsView.swift
//  VoiceBite
//
//
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userPreferencesModel: UserPreferencesModel
    @EnvironmentObject var appSettingsModel: AppSettingsModel
    let languages = ["en-GB", "en-US", "en-NZ", "en-AU"]
    
    var body: some View {
        NavigationView{
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
                        Picker("Select a language", selection: $userPreferencesModel.userPreferences.chosenLanguage) {
                            ForEach(languages, id: \.self) {
                                Text($0)
                            }
                        }.pickerStyle(.menu)
                            .onChange(of: userPreferencesModel.userPreferences.chosenLanguage) { _ in
                                updatePreferences()
                            }
                    }
                    
                    HStack{
                        SettingsBox(imageName: "moon", label: "Dark Mode", iconColour: .secondary)
                        Toggle("", isOn: $userPreferencesModel.userPreferences.isDarkMode)
                            .onChange(of: userPreferencesModel.userPreferences.isDarkMode) { _ in
                                updatePreferences()
                            }
                    }
                }
            }
            }.onReceive(userPreferencesModel.$userPreferences) { preferences in
                appSettingsModel.isDarkMode = preferences.isDarkMode
        }
        
    }
    
    func updatePreferences() {
        Task {
            do {
                try await userPreferencesModel.updatePreferences()
            } catch {
                print("DEBUG: Error updating preferences: \(error.localizedDescription)")
            }
        }
    }
}
struct SettingsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
