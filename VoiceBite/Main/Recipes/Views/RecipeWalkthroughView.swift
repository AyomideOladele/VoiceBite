//
//  RecipeWalkthroughView.swift
//  VoiceBite
//
// A view displaying a walkthrough for recipes.

import SwiftUI
import AVFoundation
import Combine

struct RecipeWalkthroughView: View {
    
    var recipe: Recipe
    @Environment(\.dismiss) var dismiss
    @State private var currentTab = 0
    @StateObject private var speechRecognizer = SpeechRecognizer()
    let synthesizer = AVSpeechSynthesizer()
    @AppStorage("chosenLanguage") private var chosenLanguage: String = "en-US"
    
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
                        
                        if let command = speechRecognizer.command {
                            Text("Heard: \(command)")
                                .padding()
                                .transition(.slide)
                                .animation(.easeInOut, value: speechRecognizer.command)
                        }
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
        .onAppear {
            try? speechRecognizer.startListening()
        }
        .onDisappear {
            speechRecognizer.stopListening()
        }
        .onChange(of: currentTab) { _ in
            speakCurrentInstruction()
            print("DEBUG: Current tab before command is handled \(currentTab)")
        }
        .onChange(of: speechRecognizer.command) { newCommand in
                    handleCommand(newCommand)
                }
    }
    
    private func speakCurrentInstruction() {
            let instruction = recipe.instructions[currentTab].description
            let utterance = AVSpeechUtterance(string: instruction)
            utterance.voice = AVSpeechSynthesisVoice(language: chosenLanguage)
            synthesizer.speak(utterance)
        }

    private func handleCommand(_ command: String?) {
        guard let command = command?.lowercased(), !command.isEmpty else { return }
        DispatchQueue.main.async {
            switch command {
            case "next":
                if currentTab < recipe.instructions.count - 1 {
                    currentTab += 1
                    print("DEBUG: Next command recognised and executed, tab changed to \(currentTab).")
                }
            case "previous":
                if currentTab > 0 {
                    currentTab -= 1
                    print("DEBUG: Previous command recognised and executed, tab changed to \(currentTab).")
                }
            default:
                print("DEBUG: Command not recognized.")
            }
        }
    }
}

struct RecipeStepView_Previews: PreviewProvider {
    static var previews: some View {
        let manager = RecipeManager()
        RecipeWalkthroughView(recipe: manager.recipes[0])
    }
}
