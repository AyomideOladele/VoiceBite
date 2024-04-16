//
//  SettingsScreenView.swift
//  VoiceBite
//
//  Created by Ayomide Oladele on 20/02/2024.
//

import SwiftUI

struct SettingsScreenView: View {
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
                        SettingsBoxView(imageName: "speaker", title: "Volume", tintColour: .secondary)
                        
                        Spacer()
                        
                        Slider(
                            value: $soundVolume,
                            in: 0...100,
                            step: 5
                        )
                    }
                    
                    HStack{
                        SettingsBoxView(imageName: "mic", title: "Speech Recognition", tintColour: .secondary)
                        
                        Toggle(isOn: $speechRecognition){}
                    }
                    
                    HStack{
                        SettingsBoxView(imageName: "mic.circle", title: "Text To Speech", tintColour: .secondary)
                        
                        Toggle(isOn: $textToSpeech){}
                    }
                    
                    HStack{
                        SettingsBoxView(imageName: "bell", title: "Notifications", tintColour: .secondary)
                        
                        Toggle(isOn: $notifications){}
                    }
                    
                    HStack{
                        SettingsBoxView(imageName: "moon", title: "Dark Mode", tintColour: .secondary)
                        
                        Toggle(isOn: $isDarkMode) {}
                    }
                    
                    // Back Button
                    //Button(action: { }) {
                    //  Text("BACK")
                    //      .padding(.vertical, 12.0)
                    //      .padding(.horizontal, 20.0)
                    //     .font(.system(size: 20, weight: .bold))
                    // }
                    // .foregroundColor(Color("SecondaryAccent"))
                    // .background(Color("TertiaryAccent"))
                    // .cornerRadius(15)
                }
            }
        }
    }
        
}

struct SettingsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreenView()
    }
}
