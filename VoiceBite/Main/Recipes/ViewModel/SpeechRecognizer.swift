//
//  SpeechRecognizer.swift
//  VoiceBite
//
// A class for recognising speech during recipe walkthroughs, and handling voice commands.

import Foundation
import AVFoundation
import Speech

class SpeechRecognizer: ObservableObject {
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-GB"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest? // Processes incoming audio data
    private var recognitionTask: SFSpeechRecognitionTask? // Processes speech recognizer results
    private let audioEngine = AVAudioEngine() // Manages audio input
    @Published var command: String? // Stores recognized commands from RecipeWalkthrough.swift
    private var lastProcessedCommand: String?
    
    init() {
        requestPermission()
    }
    
    func restartAudioBuffer() {
        stopListening()
        do {
            try startListening()
            print("DEBUG: Restarted audio buffer")
        } catch {
            print("DEBUG: Failed to restart listening: \(error)")
        }
    }
    
    func requestPermission() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                switch authStatus {
                case .authorized:
                    print("DEBUG: Permission to use speech recognition granted.")
                default:
                    print("DEBUG: Authorization to use speech recognition denied.")
                }
            }
        }
        
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            DispatchQueue.main.async {
                if granted {
                    print("DEBUG: Permission to record audio granted.")
                } else {
                    print("DEBUG: Authorization to record audio denied.")
                }
            }
        }
    }
    
    
    func startListening() throws {
        
        // Cancel existing recognition task if it exists
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        // Configure the audio session for recording
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        // Prepares the recognition request
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        recognitionRequest!.shouldReportPartialResults = true
        
        // Setup audio input node -
        let inputNode = audioEngine.inputNode
        
        // Begins recognising audio
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest!) { [weak self] result, error in
            var isFinal = false
            
            if let result = result {
                DispatchQueue.main.async {
                    let newCommand = result.bestTranscription.formattedString
                    
                    // Updates the recognised command if it's new
                    if newCommand != self?.lastProcessedCommand {
                                    self?.command = newCommand
                   
                        // Handle final recognized command
                        isFinal = result.isFinal
                            if isFinal{
                                self?.handleCommand(from: newCommand)
                                self?.lastProcessedCommand = newCommand
                                print("DEBUG: Command recognsed \(newCommand)")
                        }
                    }
                }
            }
            if let error = error {
                    print("DEBUG: Recognition task failed with error: \(error)")
                    DispatchQueue.main.async {
                        self?.restartAudioBuffer()
                    }
                } else if isFinal {
                    self?.stopListening()
                }
        }
        
        // Install an audio tap on the input node to capture audio.
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { [weak self] buffer, when in
            self?.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        
        print("DEBUG: Audio engine started successfully.")
    }
    
    func stopListening() {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            audioEngine.inputNode.removeTap(onBus: 0)
        }
    }

    // Placeholder for handling recognized commands.
    private func handleCommand(from text: String) {
        DispatchQueue.main.async {
        }
    }
}

