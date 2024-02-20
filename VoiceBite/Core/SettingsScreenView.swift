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
    @State private var darkMode = false
    
    var body: some View {
        VStack{
            // Settings Text
            Text("SETTINGS")
                .foregroundColor(Color("AccentColor"))
                .font(.system(size: 40) .bold())
                .padding()
            
            Text("Sound Volume:")
                .foregroundColor(Color("TextColour"))
                .font(.system(size: 18))
            
            Slider(
                value: $soundVolume,
                in: 0...100,
                step: 5
            )
            
            Toggle(isOn: $textToSpeech) {
                Text("Speech Recognition:")
                    .font(.system(size: 18))
            }
            
            Toggle(isOn: $speechRecognition) {
                Text("Text To Speech:")
                    .font(.system(size: 18))
            }
            
            Toggle(isOn: $notifications) {
                Text("Notifications:")
                    .font(.system(size: 18))
            }
            
            Toggle(isOn: $darkMode) {
                Text("Dark Mode:")
                    .font(.system(size: 18))
            }
            
            
            // Back Button
            Button(action: { }) {
                Text("BACK")
                    .padding(.vertical, 12.0)
                    .padding(.horizontal, 20.0)
                    .font(.system(size: 20, weight: .bold))
            }
            .foregroundColor(Color("SecondaryAccent"))
            .background(Color("TertiaryAccent"))
            .cornerRadius(15)
        }
        .frame(width: 250.0)
    }
        
}

struct SettingsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreenView()
    }
}
