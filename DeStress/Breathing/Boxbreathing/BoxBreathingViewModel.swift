//
//  BoxBreathingViewModel.swift
//  DeStress
//
//  Created by Eva Madarasz

import SwiftData
import AVFoundation
import UIKit



class BoxBreathingViewModel: ObservableObject {
    let modelContext: ModelContext // Injected context

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

    init(context: ModelContext) {
        self.modelContext = context
    }


    func completeCycle(for day: String) {
        let fetchRequest = FetchDescriptor<BreathingStatistic>(
            predicate: #Predicate<BreathingStatistic> { $0.day == day }
        )

        do {
            if let existingStatistic = try modelContext.fetch(fetchRequest).first {
                existingStatistic.cycles += 1
                print("Updated cycles for \(day): \(existingStatistic.cycles)")
            } else {
                let newStat = BreathingStatistic(day: day, cycles: 1)
                modelContext.insert(newStat)
                print("Inserted new statistic for \(day): \(newStat)")
            }
            try modelContext.save()
            print("Data saved successfully.")
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }

    func toggleBreathing() {
        if isBreathing {
            stopBreathingCycle()
        } else {
            startBreathingCycle()
        }
    }

    func startBreathingCycle() {
        isBreathing = true
        currentPhaseIndex = 0
        cycleCount = 0
        secondsRemaining = 4
        speak(currentPhase)
        runTimer()
    }

    func stopBreathingCycle() {
        isBreathing = false
        timer?.invalidate()
        saveCycle()
        resetBreathing()
    }

    func runTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.secondsRemaining > 1 {
                self.secondsRemaining -= 1
            } else {
                self.advancePhase()
            }
        }
    }

    func advancePhase() {
        timer?.invalidate()

        hapticFeedback.prepare()
        hapticFeedback.impactOccurred()

        if currentPhaseIndex == totalPhases - 1 {
            currentPhaseIndex = 0
            cycleCount += 1
            saveCycle()
        } else {
            currentPhaseIndex += 1
        }

        secondsRemaining = 4
        speak(currentPhase)
        runTimer()
    }

    func resetBreathing() {
        currentPhaseIndex = 0
        cycleCount = 0
        secondsRemaining = 4
    }

    func saveCycle() {
       guard cycleCount > 0 else { return }
        let today = getCurrentDay()
        completeCycle(for: today)
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

    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-AU")
        synthesizer.speak(utterance)
    }

    private func getCurrentDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: Date())
    }
}
