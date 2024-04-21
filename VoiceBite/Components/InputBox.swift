//
//  InputBox.swift
//  VoiceBite
//
// A view component of a reusable user input textbox, that creates either a `TextField` or a `SecureField` based on configuration

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
                    .background(Color("TextBackgroundColor")
                        .opacity(0.1))
                    .foregroundColor(Color("TextColor"))
                    .cornerRadius(7)
            } else {
                TextField(placeholder, text: $text)
                    .padding(.vertical, 5.0)
                    .padding(.horizontal, 10.0)
                    .font(.system(size: 18))
                    .background(Color("TextBackgroundColor")
                        .opacity(0.1))
                    .foregroundColor(Color("TextColor"))
                    .cornerRadius(7)
            }
        }
    }
    
    struct InputBox_Previews: PreviewProvider {
        static var previews: some View {
            InputBox(text: .constant(""), placeholder: "placeholder")
        }
    }
}
