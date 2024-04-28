//
//  InputBox.swift
//  VoiceBite
//
// A view component of a user input textbox, that creates either a `TextField` or a `SecureField` based on configuration

import SwiftUI

struct InputBox: View {
    
    @Binding var text: String // Represents user input to the text field
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 12) {
            
            if isSecureField{
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
            
        }.padding(.vertical, 8.0)
         .padding(.horizontal, 15.0)
         .font(.system(size: 18))
         .background(Color("TextBackgroundColor").opacity(0.2))
         .foregroundColor(Color("TextColor"))
         .cornerRadius(7)
         .autocapitalization(.none)
         .disableAutocorrection(true)
    }
    
    struct InputBox_Previews: PreviewProvider {
        static var previews: some View {
            InputBox(text: .constant(""), placeholder: "placeholder")
        }
    }
}


