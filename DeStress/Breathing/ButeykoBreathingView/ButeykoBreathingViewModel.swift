//
//  ButeykoBreathingViewModel.swift
//  DeStress
//
//  Created by Eva Sira Madarasz on 12/11/2024.
//

import SwiftUI
import AVFoundation
import SwiftData

class ButeykoBreathingViewModel: ObservableObject {
   
    
    @Published var countdown = 5
    @Published var isBreathHeld = false
    @Published var controlPause = 0
    @Published var isMeasuringCP = false
    @Published var controlPauseHistory: [Int] = []

    private var timer: Timer?
    private let synthesizer = AVSpeechSynthesizer()

  
    func startCountdown() {
        stopTimers() // No overlapping timers
        countdown = 5
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.countdown > 1 {
                self.countdown -= 1
            } else {
                self.stopTimers()
                self.isBreathHeld = true
                self.startControlPauseMeasurement()
            }
        }
    }

    
    func startControlPauseMeasurement() {
        stopTimers()
        isMeasuringCP = true
        controlPause = 0
        speak("Hold your breath")
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.controlPause += 1
        }
    }

   
    func stopControlPauseMeasurement() {
        stopTimers()
        isMeasuringCP = false
        controlPauseHistory.append(controlPause)
        controlPause = 0 // Reset for the next measurement
        speak("Breathe normally")
    }

   
    func stopExercise() {
        stopTimers()
        isMeasuringCP = false
        isBreathHeld = false
        countdown = 5
        controlPause = 0
        speak("Exercise stopped")
    }

   
    private func stopTimers() {
        timer?.invalidate()
        timer = nil
    }

    // Speak the provided text
    private func speak(_ text: String) {
        synthesizer.stopSpeaking(at: .immediate)
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate * 0.7
        utterance.pitchMultiplier = 1.1
        synthesizer.speak(utterance)
    }

  
    deinit {
        stopTimers()
    }
}
