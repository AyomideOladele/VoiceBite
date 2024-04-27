//
//  RecipeWalkthroughView.swift
//  VoiceBite
//
// A view displaying a walkthrough for recipes.

import SwiftUI
import AVFoundation
import AVKit
import Combine
let synthesizer = AVSpeechSynthesizer()

struct RecipeWalkthroughView: View {
    
    var recipe: Recipe
    @Environment(\.dismiss) var dismiss
    @State private var currentTab = 0
    @State private var chosenLanguage = "en-US"
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            TabView(selection: $currentTab) {
                ForEach(recipe.instructions.indices, id: \.self) { index in
                    VStack {
                        Image(recipe.instructions[index].imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 150)
                            .padding(18)
                            .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 4)
                            .padding()
                        
                        Image(systemName: "\(index + 1).circle.fill")
                            .imageScale(.large)
                        
                        
                        Text(recipe.instructions[index].description)
                            .padding()
                            .font(.system(size: 20, weight: .bold))
                        
                        ForEach(recipe.instructions[index].details, id: \.self) { detail in
                            Text(detail)
                                .font(.system(size: 17))
                                .foregroundColor(Color("TextColor"))
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .frame(alignment: .center)
                                .multilineTextAlignment(.center)
                        }
                       
                        Image(systemName: "mic.circle.fill")
                            .font(.system(size: 100))
                            .foregroundColor(Color("AccentColor"))
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
        .onAppear {
            speakCurrentInstruction()
            try? speechRecognizer.startListening()
        }
        .onDisappear {
            synthesizer.stopSpeaking(at: .immediate)
            speechRecognizer.stopListening()
        }
        .onChange(of: currentTab) { _ in
            synthesizer.stopSpeaking(at: .immediate)
            speakCurrentInstruction()
        }
        .onChange(of: speechRecognizer.command) {
            newCommand in handleCommand(newCommand)
            print("DEBUG: Current tab after command is handled \(currentTab)")
        }
    }
    
    
    private func handleCommand(_ command: String?) {
        guard let command = command?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased(), !command.isEmpty else { return }

        // Split the command string into words
        let words = command.split(separator: " ")
        if let lastWord = words.last {
            
            // Process the last word of the command
            switch String(lastWord) {
            case "next":
                if currentTab < recipe.instructions.count - 1 {
                    currentTab += 1
                    print("DEBUG: Next command recognised and executed, tab changed to \(currentTab).")
                }
            case "previous", "back":
                if currentTab > 0 {
                    currentTab -= 1
                    print("DEBUG: Previous command recognised and executed, tab changed to \(currentTab).")
                }
            case "repeat":
                speakCurrentInstruction()
                print("DEBUG: Repeat command recognised and executed, instruction on tab \(currentTab) repeated.")
                
            case "finish":
                dismiss()
                print("DEBUG: exit command recognised and executed, view dismissed")
            
            default:
                print("DEBUG: Command \(command) not recognized.")
            }
        }
    }
    
    private func setTTSLanguage () {
            if let user = viewModel.currentUser {
                chosenLanguage = user.chosenLanguage
            }
    }
    
    
    private func speakCurrentInstruction() {
        
        print("DEBUG: Instruction called to speak on tab \(currentTab)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let instruction = recipe.instructions[currentTab].description
            let utterance = AVSpeechUtterance(string: instruction)
            utterance.voice = AVSpeechSynthesisVoice(language: chosenLanguage)
            synthesizer.speak(utterance)
        }
    }
}

struct RecipeWalkthroughView_Previews: PreviewProvider {
    static var previews: some View {
        
        let manager = RecipeManager()
        
        RecipeWalkthroughView(recipe: manager.recipes[0])
    }
}


