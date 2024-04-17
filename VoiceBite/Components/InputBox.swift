//
//  InputView.swift
//  VoiceBite
//
//  Created by Ayomide Oladele on 19/02/2024.
//

import SwiftUI

struct InputBox: View {
    @Binding var text: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack (alignment: .leading, spacing: 12){
            if isSecureField{
                SecureField(placeholder, text: $text)
                    .padding(.vertical, 5.0)
                    .padding(.horizontal, 10.0)
                    .font(.system(size: 18))
                    .background(Color("QuaternaryAccent")
                        .opacity(0.1))
                    .foregroundColor(Color("TextColour"))
                    .cornerRadius(7)
            } else {
                TextField(placeholder, text: $text)
                    .padding(.vertical, 5.0)
                    .padding(.horizontal, 10.0)
                    .font(.system(size: 18))
                    .background(Color("QuaternaryAccent")
                        .opacity(0.1))
                    .foregroundColor(Color("TextColour"))
                    .cornerRadius(7)
            }
        }
    }
    
    struct InputView_Previews: PreviewProvider {
        static var previews: some View {
            InputBox(text: .constant(""), placeholder: "placeholder")
        }
    }
}
