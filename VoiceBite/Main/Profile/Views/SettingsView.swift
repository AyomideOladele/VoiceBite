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
                        SettingsBox(imageName: "speaker", label: "Volume", iconColour: .secondary)
                        
                        Spacer()
                        Slider(
                            value: $userPreferencesModel.userPreferences.soundVolume,
                            in: 0...100, step: 5
                        ).onChange(of: userPreferencesModel.userPreferences.soundVolume) { _ in updatePreferences()}
                    }
                    
                    HStack{
                        SettingsBox(imageName: "mic", label: "Speech Recognition", iconColour: .secondary)
                        Toggle("", isOn: $userPreferencesModel.userPreferences.speechRecognitionEnabled
                        ).onChange(of: userPreferencesModel.userPreferences.speechRecognitionEnabled) { _ in updatePreferences()}
                    }
                    
                    HStack{
                        SettingsBox(imageName: "mic.circle", label: "Text To Speech", iconColour: .secondary)
                        Toggle("", isOn: $userPreferencesModel.userPreferences.textToSpeechEnabled).onChange(of: userPreferencesModel.userPreferences.textToSpeechEnabled) { _ in
                            updatePreferences()}
                    }
                    
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
