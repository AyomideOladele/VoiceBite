//
//  TutorialView.swift
//  VoiceBite
//

import SwiftUI

struct TutorialView: View {
    var body: some View {
            VStack{
                
                Text("VOICE COMMANDS")
                    .fontWeight(.bold)
                    .foregroundColor(Color("AccentColor"))
                    .padding(.vertical, 5.0)
                    .font(.title)
                
                
                Text("To continue to the next step of a recipe say:")
                    .fontWeight(.bold)
                    .foregroundColor(Color("TextColor"))
                    .padding(.vertical, 5.0)
                    .font(.headline)
                
                Text("Next")
                    .foregroundColor(Color("TextColor"))
                
                Text("To return to a previous step of a recipe say:")
                    .fontWeight(.bold)
                    .foregroundColor(Color("TextColor"))
                    .padding(.vertical, 5.0)
                    .font(.headline)
                
                HStack {
                    Text("Previous")
                    Text("or")
                    Text("Go Back")
                }.foregroundColor(Color("TextColor"))
                
                Text("To repeat a spoken recipe instruction say:")
                    .fontWeight(.bold)
                    .foregroundColor(Color("TextColor"))
                    .padding(.vertical, 5.0)
                    .font(.headline)
                
                Text("Repeat")
                    .foregroundColor(Color("TextColor"))
                
                Text("To end a recipe walkthrough say:")
                    .fontWeight(.bold)
                    .foregroundColor(Color("TextColor"))
                    .padding(.vertical, 5.0)
                    .font(.headline)

                Text("Finish")
                    .foregroundColor(Color("TextColor"))
                
            }//.padding(.top, -200)
       //}.navigationBarTitle("Tutorial", displayMode: .inline)
        //.navigationBarHidden(true)
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
