//
//  SpeechRecognizer.swift
//  VoiceBite
//
//  Created by Ayomide Oladele on 15/04/2024.
//

import Foundation
import AVFoundation
import Speech

class SpeechRecognizer: ObservableObject {
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    @Published var command: String?
    @Published var audioLevel: Float = 0.0  // For displaying the audio input level
    
    // Timer to restart the audio buffer periodically
    private var restartTimer: Timer?
    
    // Interval for restarting the audio buffer
    private let restartInterval: TimeInterval = 3 // Adjust this time based on your need
    
    init() {
        requestPermission()
        setupAudioBufferRestart()
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
        } catch {
            print("Failed to restart listening: \(error)")
        }
    }
    
    func requestPermission() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                switch authStatus {
                case .authorized:
                    print("DEBUG: Permission to use speech recognition granted.")
                    self.restartAudioBuffer()
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
        
        // Set up recognition task
        /*recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest!) { [weak self] result, error in
            var isFinal = false
            
            if let result = result {
                DispatchQueue.main.async {
                    self?.command = result.bestTranscription.formattedString
                    isFinal = result.isFinal
                }
            }
            
            if error != nil || isFinal {
                self?.stopListening()
            }
        }*/
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest!) { [weak self] result, error in
            var isFinal = false
            
            if let result = result {
                DispatchQueue.main.async {
                    self?.command = result.bestTranscription.formattedString
                    isFinal = result.isFinal
                    if isFinal {
                        self?.command = nil // Clear command right after setting it to avoid duplicate processing
                    }
                }
            }
            
            if error != nil || isFinal {
                self?.stopListening()
            }
        }

        
        
        // Install tap on inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { [weak self] buffer, when in
            self?.recognitionRequest?.append(buffer)
        }
        
        
        audioEngine.prepare()
        try audioEngine.start()
    }
    
    func stopListening() {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            audioEngine.inputNode.removeTap(onBus: 0)
        }
    }
    
    private func handleCommand(from text: String) {
        DispatchQueue.main.async {
            print("Received command: \(text)")
            self.command = nil  // Clear the command immediately after receiving it to prevent reprocessing
            print("Emptied command: \(text)")
        }
    }
    
}
