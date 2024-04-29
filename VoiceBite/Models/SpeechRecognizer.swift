//
//  SpeechRecognizer.swift
//  VoiceBite
//
// A model for recognising speech during recipe walkthroughs and handling voice commands.

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
    
    // Attempts to restart audio listening session
    func restartAudioBuffer() {
        stopListening()
        do {
            try startListening()
            print("DEBUG: Restarted audio buffer")
        } catch {
            print("DEBUG: Failed to restart listening: \(error)")
        }
    }
    
    // Checks app has permissions from user to use speech recognition and record audio
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
        
        // Checks if there is an existing recognition task
        // If there is, it is cancelled and cleared to prevent overlapping speech recognition
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        // Retrieves an instances of AVAudioSession
        let audioSession = AVAudioSession.sharedInstance()
        
        // Configures audio session to record incoming audio, reduces processing of background noise, and lowers the volume of any audio playing
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        
        // Activates audio session, and sets it to notify other audio sessions when it is deactivated
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        // Creates new instance of speech recognition class
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        // Sets recognizer to return partial results so processing is done in real time
        recognitionRequest!.shouldReportPartialResults = true
        
        // Setup microphone to recieve audio for processing
        let inputNode = audioEngine.inputNode
        
        // Begins a speech recognition task
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest!) { [weak self] result, error in
            
            var isFinalResult = false 
            
            // Checks if speech has been captured and recognised, if so begins handling
            if let result = result {
                
                // Processes speech in the main thread
                DispatchQueue.main.async {
                    
                    // Stores the most accurate transcription
                    let newCommand = result.bestTranscription.formattedString
                    
                    // Checks if the new transcription is different from the last one
                    if newCommand != self?.lastProcessedCommand {
                                    self?.command = newCommand // Update command if it's different
                   
                        // When a final result is reached, the command is handled
                        isFinalResult = result.isFinal
                            if isFinalResult{
                                self?.command = newCommand // Updates command 
                                self?.lastProcessedCommand = newCommand // Updates the last processed command
                                print("DEBUG: Command recognsed \(newCommand)")
                        }
                    }
                }
            }
            // If an error occurs, stop listening
            if let error = error {
                    print("DEBUG: Recognition task failed with error: \(error)")
                    DispatchQueue.main.async {
                        self?.restartAudioBuffer()
                    }
                } else if isFinalResult {
                    self?.stopListening()
                }
        }
        
        // Stores the recording format of the users microphone
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        
        // Installs audio tap on microphone to recieve audio
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { [weak self] buffer, when in
            self?.recognitionRequest?.append(buffer)
        }
        
        // Prepare and begin to start recieving audio - called after all other components are functional
        audioEngine.prepare()
        try audioEngine.start()
        
        print("DEBUG: Audio engine started successfully.")
    }
    
    func stopListening() {
        
        // Stops audio engine, ends recognition request, and removes audio tap from microphone
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            audioEngine.inputNode.removeTap(onBus: 0)
        }
    }
}

