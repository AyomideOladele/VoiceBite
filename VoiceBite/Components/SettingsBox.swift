//
//  SettingsBoxView.swift
//  VoiceBite
//
// A view component for a settings box, with a label and icon

import SwiftUI

struct SettingsBox: View {
    let imageName: String
    let label: String
    let iconColour: Color
    
    // Creates view of icon and label, formatted horizontally
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .font(.system(size: 20))
                .foregroundColor(iconColour)
            
            Text(label)
                .font(.system(size: 16))
                .foregroundColor(Color("TextColor"))
        }
    }
}

struct SettingsBoxView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsBox(imageName: "gear", label: "label", iconColour: Color("IconButtonColor"))
    }
}
