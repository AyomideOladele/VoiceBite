//
//  SettingsView.swift
//  VoiceBite
//
//
//

import SwiftUI

struct SettingsView: View {
    @State private var soundVolume = 50.0
    @State private var textToSpeech = true
    @State private var speechRecognition = true
    @State private var notifications = true
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        NavigationStack{
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
                            value: $soundVolume,
                            in: 0...100,
                            step: 5
                        )
                    }
                    
                    HStack{
                        SettingsBox(imageName: "mic", label: "Speech Recognition", iconColour: .secondary)
                        
                        Toggle(isOn: $speechRecognition){}
                    }
                    
                    HStack{
                        SettingsBox(imageName: "mic.circle", label: "Text To Speech", iconColour: .secondary)
                        
                        Toggle(isOn: $textToSpeech){}
                    }
                    
                    HStack{
                        SettingsBox(imageName: "bell", label: "Notifications", iconColour: .secondary)
                        
                        Toggle(isOn: $notifications){}
                    }
                    
                    HStack{
                        SettingsBox(imageName: "moon", label: "Dark Mode", iconColour: .secondary)
                        
                        Toggle(isOn: $isDarkMode) {}
                    }
                }
            }
        }
    }
        
}

struct SettingsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
