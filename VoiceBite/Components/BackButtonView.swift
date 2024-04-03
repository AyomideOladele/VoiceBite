//
//  BackButtonView.swift
//  VoiceBite
//
//  Created by Ayomide Oladele on 11/03/2024.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        // Back Button
        Button(action: {
            //Dismisses the current view of the navigation stack
            self.presentationMode.wrappedValue.dismiss()
        }) {
            //Formats button's text apperance
            Text("BACK")
                .padding(.vertical, 12.0)
                .padding(.horizontal, 20.0)
                .font(.system(size: 20, weight: .bold))
        }
        //Formats button's background apperance
        .foregroundColor(Color("SecondaryAccent"))
        .background(Color("TertiaryAccent"))
        .cornerRadius(15)
        .padding(.top, 100.0)
    }
}

struct BackButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BackButtonView()
    }
}
