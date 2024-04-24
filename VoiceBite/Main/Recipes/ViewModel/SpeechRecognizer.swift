//
//  SpeechRecognizer.swift
//  VoiceBite
//

import Foundation
import AVFoundation
import Speech

class SpeechRecognizer: ObservableObject {
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-GB"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest? // Processes audio data
    private var recognitionTask: SFSpeechRecognitionTask? // Processes result of speech recognizer
    private let audioEngine = AVAudioEngine() // Manages audio input
    @Published var command: String? // Stores recognized commands from RecipeWalkthrough.swift
    private var lastProcessedCommand: String?
    
    // Timer to restart the audio buffer periodically
    private var restartTimer: Timer?
    // Interval for restarting the audio buffer
    private let restartInterval: TimeInterval = 3 // Adjust this time based on your need
    
    init() {
        requestPermission()
    }
    
    func setupAudioBufferRestart() {
            restartTimer = Timer.scheduledTimer(withTimeInterval: restartInterval, repeats: true) { [weak self] _ in
                self?.restartAudioBuffer()
            }
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
                    //self.restartAudioBuffer()
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
        
        // Configure the audio session
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        // Configure the recognition request
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        recognitionRequest!.shouldReportPartialResults = true
        
        let inputNode = audioEngine.inputNode
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest!) { [weak self] result, error in
            var isFinal = false
            
            if let result = result {
                DispatchQueue.main.async {
                    let newCommand = result.bestTranscription.formattedString
                    
                    if newCommand != self?.lastProcessedCommand {
                                    self?.command = newCommand
                   
                        isFinal = result.isFinal
                            if isFinal{
                                self!.command = ""
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
        
        // Install tap on inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { [weak self] buffer, when in
            //print("DEBUG: Audio buffer received: \(buffer)")
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

    private func handleCommand(from text: String) {
        //clearCommand()
        DispatchQueue.main.async {
            //print("DEBUG: Received command: \(text)")
            //self.command = nil  // Clear the command immediately after receiving it to prevent reprocessing
            
            print("DEBUG: Command handled and cleared: \(text)")
        }
        //clearCommand()
    }
    
    func clearCommand() {
        DispatchQueue.main.async {
            self.command = nil
        }
    }
    
}

