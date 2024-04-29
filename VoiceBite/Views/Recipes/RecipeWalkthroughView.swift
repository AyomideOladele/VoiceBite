//
//  RecipeWalkthroughView.swift
//  VoiceBite
//
// A view displaying a walkthrough for recipes + ASR and TTS

import SwiftUI
import AVFoundation
import AVKit
import Combine
let synthesizer = AVSpeechSynthesizer() // Initialise speech synthesizer for TTS

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
                
                // Loops through each instruction in the recipe
                ForEach(recipe.instructions.indices, id: \.self) { index in
                    VStack {
                        
                        // Displays the recipe step image
                        Image(recipe.instructions[index].imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 150)
                            .padding(18)
                            .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 4)
                            .padding()
                        
                        // Displays the index of the current tab as the recipe instruction step
                        Image(systemName: "\(index + 1).circle.fill")
                            .imageScale(.large)
                        
                        // Displays the recipe instruction
                        Text(recipe.instructions[index].description)
                            .padding()
                            .font(.system(size: 20, weight: .bold))
                        
                        // Loops through each detail of the recipe instruction, and displays them in order
                        ForEach(recipe.instructions[index].details, id: \.self) { detail in
                            Text(detail)
                                .font(.system(size: 17))
                                .foregroundColor(Color("TextColor"))
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .frame(alignment: .center)
                                .multilineTextAlignment(.center)
                        }
                       
                        // Mic image for indicating speech recognition is present
                        Image(systemName: "mic.circle.fill")
                            .font(.system(size: 100))
                            .foregroundColor(Color("AccentColor"))
                        
                    }// Gives each tab an index so they can be used to identify which tab we're on
                    .tag(index)
                }
            } // Configures tab view indicator, shown at bottom of view
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
        // Speaks current instruction to be spoken when view appears, and begins speech recognition
        .onAppear {
            speakCurrentInstruction()
            try? speechRecognizer.startListening()
        }
        // When view disappears, interrupts if current instruction is being spoken, and stops speech recognition
        .onDisappear {
            synthesizer.stopSpeaking(at: .immediate)
            speechRecognizer.stopListening()
        }
        // When the tab view changes, interrupts if current instruction is being spoken, and starts to read new instruction
        .onChange(of: currentTab) { _ in
            synthesizer.stopSpeaking(at: .immediate)
            speakCurrentInstruction()
        }
        // When speech is heard, passes it to the command handler
        .onChange(of: speechRecognizer.command) {
            newCommand in handleCommand(newCommand)
            print("DEBUG: Current tab after command is handled \(currentTab)")
        }
    }
    
    
    private func handleCommand(_ command: String?) {
        
        // Cleans command of unnecessary characters, returns if empty
        guard let command = command?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased(), !command.isEmpty else { return }

        // Split the command string into words
        let words = command.split(separator: " ")
        if let lastWord = words.last {
            
            // Process the last word of the command, and proceeds accordingly
            switch String(lastWord) {
            case "next":
                if currentTab < recipe.instructions.count - 1 {
                    currentTab += 1
                    print("DEBUG: Next command recognised and executed, tab changed to \(currentTab).")
                }
            case "previous", "back":
                if currentTab > 0 {
                    currentTab -= 1
                    print("DEBUG: Previous/Back command recognised and executed, tab changed to \(currentTab).")
                }
            case "repeat":
                speakCurrentInstruction()
                print("DEBUG: Repeat command recognised and executed, instruction on tab \(currentTab) repeated.")
                
            case "finish":
                dismiss()
                print("DEBUG: Exit command recognised and executed, view dismissed")
            
            default:
                print("DEBUG: Command \(command) not recognized.")
            }
        }
    }
    
    // Speaks the current instruction after a short delay
    private func speakCurrentInstruction() {
        
        // Sets chosen language if user session is active, if not defaults to en-US
        if let user = viewModel.currentUser {
            chosenLanguage = user.chosenLanguage
        }
        
        print("DEBUG: Instruction called to speak on tab \(currentTab)")
        
        // Delays Text-To-Speech for 1 second to allow for full tab change
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            // Sets current instruction as speech to be spoken
            let instruction = recipe.instructions[currentTab].description
            let utterance = AVSpeechUtterance(string: instruction)
            
            utterance.voice = AVSpeechSynthesisVoice(language: chosenLanguage) // Sets voice language
            synthesizer.speak(utterance) // Speaks instruction
        }
    }
}

struct RecipeWalkthroughView_Previews: PreviewProvider {
    static var previews: some View {
        let manager = RecipeManager()
        RecipeWalkthroughView(recipe: manager.recipes[0])
    }
}


