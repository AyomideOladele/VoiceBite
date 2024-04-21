//
//  SettingsBoxView.swift
//  VoiceBite
//
// Template Icon made to be reused for setting icons/buttons
// Made using AppStuff Guide
//
//  Created by Ayomide Oladele on 04/04/2024.
//

import SwiftUI

struct SettingsBox: View {
    let imageName: String
    let title: String
    let iconColour: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(iconColour)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(Color("TextColor"))
        }
    }
}

struct SettingsBoxView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsBox(imageName: "gear", title: "Version", iconColour: Color(.systemRed))
    }
}
