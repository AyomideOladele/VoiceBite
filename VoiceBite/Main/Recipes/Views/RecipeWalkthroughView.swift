//
//  RecipeWalkthroughView.swift
//  VoiceBite
//
//  Created by Ayomide Oladele on 17/04/2024.
//
import SwiftUI
import Combine

struct RecipeWalkthroughView: View {
    var recipe: Recipe
    @Environment(\.dismiss) var dismiss
    @State private var currentTab = 0
    @StateObject private var speechRecognizer = SpeechRecognizer()
    
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
        .onChange(of: speechRecognizer.command) { newValue in
            print("DEBUG: Current tab before command is handled \(currentTab)")
            guard let command = newValue?.lowercased(), !command.isEmpty else { return }
                handleCommand(command)
            //handleCommand(newValue)
        }
    }

    private func handleCommand(_ command: String?) {
        //guard let command = command?.lowercased() else { return }

        //print("Handling command: \(String(describing: command))")
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
