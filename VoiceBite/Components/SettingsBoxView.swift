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

struct SettingsBoxView: View {
    let imageName: String
    let title: String
    let tintColour: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColour)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(Color("TextColour"))
        }
    }
}

struct SettingsBoxView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsBoxView(imageName: "gear", title: "Version", tintColour: Color(.systemRed))
    }
}
