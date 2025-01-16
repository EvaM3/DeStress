//
//  FourSevenEightBreathingViewModel.swift
//  DeStress
//
//  Created by Eva Madarasz
//

import Foundation
import AVFoundation
import Combine

class FourSevenEightBreathingViewModel: ObservableObject {
    @Published var isBreathing = false
    @Published var breathPhase: String = "Inhale"
    @Published var breathOpacity: Double = 1.0
    @Published var breathSize: CGFloat = 1.0
    @Published var cycleCount: Int = 0
    @Published var countdown: Int = 4

     let inhaleDuration: Double = 4.0
     let holdDuration: Double = 7.0
     let exhaleDuration: Double = 8.0
     let synthesizer = AVSpeechSynthesizer()
     var timer: Timer?

    func startBreathingCycle() {
        isBreathing = true
        cycleCount = 0
        countdown = Int(inhaleDuration)
        breathPhase = "Inhale"
        nextBreathingPhase()
    }

    func stopBreathingCycle() {
        isBreathing = false
        breathPhase = "Inhale"
        breathOpacity = 1.0
        breathSize = 1.0
        countdown = Int(inhaleDuration)
        timer?.invalidate()
        timer = nil
    }

    private func nextBreathingPhase() {
        guard isBreathing else { return }

        updateBreathPhase("Inhale", duration: inhaleDuration) {
            self.updateBreathPhase("Hold", duration: self.holdDuration) {
                self.updateBreathPhase("Exhale", duration: self.exhaleDuration) {
                    self.cycleCount += 1
                    self.nextBreathingPhase()
                }
            }
        }
    }

    private func updateBreathPhase(_ phase: String, duration: Double, completion: @escaping () -> Void) {
        breathPhase = phase
        countdown = Int(duration)
        speak(phase)

        // Update animation properties
        breathOpacity = (phase == "Exhale") ? 0.6 : 1.0
        breathSize = (phase == "Exhale") ? 0.75 : 1.0

        startCountdown(for: duration, completion: completion)
    }

        func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        if let voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Matilda-compact") {
            utterance.voice = voice
        } else {
            utterance.voice = AVSpeechSynthesisVoice(language: "en-AU")
        }
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate * 0.9
        synthesizer.speak(utterance)
    }

    private func startCountdown(for duration: Double, completion: @escaping () -> Void) {
        var timeRemaining = Int(duration)
        countdown = timeRemaining

        timer?.invalidate()

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            timeRemaining -= 1
            self.countdown = timeRemaining

            if timeRemaining <= 0 {
                timer.invalidate()
                completion()
            }
        }
    }
}

