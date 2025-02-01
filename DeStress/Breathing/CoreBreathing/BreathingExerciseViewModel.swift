//
//  BreathingExerciseViewModel.swift
//  DeStress
//
//  Created by Eva Madarasz
//

import Foundation
import HealthKit
import AVFoundation
import SwiftData

class BreathingExerciseViewModel: ObservableObject {
    @Published var isCountdownActive: Bool = true
    @Published var isExerciseComplete: Bool = false
    @Published var timer: Timer?
    @Published var timeLeft: Int = 60
    @Published var breathIn: Bool = true
    @Published var countdown: Int = 5
    private(set) var isHealthKitAuthorized: Bool = false
    
    var settings: BreathingSettings
    private let healthKitManager: HealthKitManager
    private let synthesizer = AVSpeechSynthesizer()
    private var currentPhaseTimeLeft: Int = 0
    private var context: ModelContext // SwiftData
    
    init(context: ModelContext, settings: BreathingSettings = BreathingSettings(), healthKitManager: HealthKitManager = HealthKitManager.shared) {
        self.context = context
        self.settings = settings
        self.healthKitManager = healthKitManager
    }
    
    // MARK: - Save Session to SwiftData
    func saveMindfulnessSession() {
        let newSession = BreathingSession(
            duration: 60,
            inhaleDuration: settings.inhaleDuration,
            exhaleDuration: settings.exhaleDuration
        )
        context.insert(newSession)
        
        do {
            try context.save()
            print("Mindfulness session saved successfully.")
        } catch {
            print("Failed to save mindfulness session: \(error)")
        }
    }
    
    
    // MARK: - Exercise Control
    
    func startCountdown() {
        stopExercise()
        isCountdownActive = true
        countdown = 5
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            if self.countdown > 0 {
                self.countdown -= 1
            } else {
                timer.invalidate()
                self.isCountdownActive = false
                self.startExercise()
            }
        }
    }
    
    
    func startExercise() {
        guard isHealthKitAuthorized else { return }
        
        isCountdownActive = false  // Mark countdown as inactive
        resetExercisePhase()
        isExerciseComplete = false
        timeLeft = 60
        currentPhaseTimeLeft = Int(breathIn ? settings.inhaleDuration : settings.exhaleDuration)
        
        stopSpeech()
        speak(breathIn ? "Breathe In" : "Breathe Out")
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            if self.timeLeft <= 0 {
                timer.invalidate()
                self.isExerciseComplete = true
                self.saveMindfulnessSession()
            } else {
                self.handleBreathingPhases()
                self.timeLeft -= 1
            }
        }
    }
    
    
    func stopExercise() {
        timer?.invalidate()
        timer = nil
        stopSpeech()
        resetExercisePhase()
    }
    
    
    func resetExercise() {
        stopExercise()
        isCountdownActive = true
        countdown = 5
        isExerciseComplete = false
        timeLeft = 60
    }
    
    // MARK: - Breathing Phase Logic
    
    private func handleBreathingPhases() {
        if currentPhaseTimeLeft > 0 {
            currentPhaseTimeLeft -= 1
        } else {
            breathIn.toggle()
            currentPhaseTimeLeft = Int(breathIn ? settings.inhaleDuration : settings.exhaleDuration)
            stopSpeech()
            speak(breathIn ? "Breathe In" : "Breathe Out")
        }
    }
    
    
    private func resetExercisePhase() {
        breathIn = true
        currentPhaseTimeLeft = Int(settings.inhaleDuration)
    }
    
    
    // MARK: - HealthKit Integration
    
    func requestHealthKitAuthorization() {
        healthKitManager.requestAuthorization { [weak self] success, _ in
            self?.isHealthKitAuthorized = success
        }
    }
    
    // MARK: - Speech Functionality
    
    private func speak(_ text: String) {
        stopSpeech()
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-AU")
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate * 0.9
        synthesizer.speak(utterance)
    }
    
    private func stopSpeech() {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
    }
    
}
