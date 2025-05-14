//
//  BoxBreathingViewModel.swift
//  DeStress
//
//  Created by Eva Madarasz

import SwiftData
import AVFoundation
import UIKit

class BoxBreathingViewModel: ObservableObject {
    let phases = ["Inhale", "Hold", "Exhale", "Hold"]
    let totalPhases = 4
    private let hapticFeedback = UIImpactFeedbackGenerator(style: .medium)
    let synthesizer = AVSpeechSynthesizer()

    @Published var currentPhaseIndex = 0
    @Published var cycleCount = 0
    @Published var isBreathing = false
    @Published var secondsRemaining = 4
    @Published var timer: Timer?

    var currentPhase: String {
        phases[currentPhaseIndex]
    }

    func toggleBreathing(onCycleComplete: @escaping () -> Void) {
        isBreathing ? stopBreathing(onCycleComplete) : startBreathingCycle(onCycleComplete)
    }

    private func startBreathingCycle(_ onCycleComplete: @escaping () -> Void) {
        isBreathing = true
        currentPhaseIndex = 0
        cycleCount = 0
        secondsRemaining = 4
        speak(currentPhase)
        runTimer(onCycleComplete)
    }

    private func stopBreathing(_ onCycleComplete: @escaping () -> Void) {
        isBreathing = false
        timer?.invalidate()

        if cycleCount > 0 {
            onCycleComplete()
        }

        resetBreathing()
    }

    private func runTimer(_ onCycleComplete: @escaping () -> Void) {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.secondsRemaining > 1 {
                self.secondsRemaining -= 1
            } else {
                self.advancePhase(onCycleComplete)
            }
        }
    }

    private func advancePhase(_ onCycleComplete: @escaping () -> Void) {
        timer?.invalidate()
        hapticFeedback.prepare()
        hapticFeedback.impactOccurred()

        if currentPhaseIndex == totalPhases - 1 {
            currentPhaseIndex = 0
            cycleCount += 1
            onCycleComplete()
        } else {
            currentPhaseIndex += 1
        }

        secondsRemaining = 4
        speak(currentPhase)
        runTimer(onCycleComplete)
    }

    private func resetBreathing() {
        currentPhaseIndex = 0
        cycleCount = 0
        secondsRemaining = 4
    }

    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-AU")
        synthesizer.speak(utterance)
    }

    func circleUIColor(for phase: String) -> UIColor {
        switch phase {
        case "Inhale", "Exhale":
            return UIColor(red: 0.3, green: 0.5, blue: 0.7, alpha: 1.0)
        case "Hold":
            return UIColor(red: 0.4, green: 0.5, blue: 0.6, alpha: 1.0)
        default:
            return UIColor(red: 0.3, green: 0.5, blue: 0.7, alpha: 1.0)
        }
    }
}

