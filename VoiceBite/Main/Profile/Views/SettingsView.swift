//
//  SettingsScreenView.swift
//  VoiceBite
//
//  Created by Ayomide Oladele on 20/02/2024.
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
                        SettingsBox(imageName: "speaker", title: "Volume", iconColour: .secondary)
                        
                        Spacer()
                        
                        Slider(
                            value: $soundVolume,
                            in: 0...100,
                            step: 5
                        )
                    }
                    
                    HStack{
                        SettingsBox(imageName: "mic", title: "Speech Recognition", iconColour: .secondary)
                        
                        Toggle(isOn: $speechRecognition){}
                    }
                    
                    HStack{
                        SettingsBox(imageName: "mic.circle", title: "Text To Speech", iconColour: .secondary)
                        
                        Toggle(isOn: $textToSpeech){}
                    }
                    
                    HStack{
                        SettingsBox(imageName: "bell", title: "Notifications", iconColour: .secondary)
                        
                        Toggle(isOn: $notifications){}
                    }
                    
                    HStack{
                        SettingsBox(imageName: "moon", title: "Dark Mode", iconColour: .secondary)
                        
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
