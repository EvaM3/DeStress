//
//  ButeykoBreathingViewModel.swift
//  DeStress
//
//  Created by Eva Madarasz on 12/11/2024.
//

import SwiftUI
import AVFoundation
import SwiftData

class ButeykoBreathingViewModel: ObservableObject {
   
    
    @Published var countdown = 5
    @Published var isBreathHeld = false
    @Published var controlPause = 0
    @Published var isMeasuringCP = false
    
    @Published var controlPauseHistory: [ControlPauseRecord] = []
    
    private var timer: Timer?
    private let synthesizer = AVSpeechSynthesizer()
   
   
    private var modelContext: ModelContext?

       func setContext(_ context: ModelContext) {
           self.modelContext = context
       }
  
    @MainActor
    func fetchSavedHistory() async {
        guard let context = modelContext else {
            print("❌ modelContext is nil — cannot fetch")
            return
        }

        print("🔄 Fetching CP history...")
        let descriptor = FetchDescriptor<ControlPauseRecord>(sortBy: [SortDescriptor(\.timestamp)])
        do {
            let results = try context.fetch(descriptor)
            print("✅ Fetched \(results.count) CP records")
            controlPauseHistory = results
        } catch {
            print("❌ Error fetching CP history: \(error)")
        }
    }


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
        speak("Breathe normally")

        let record = ControlPauseRecord(duration: controlPause)
        modelContext?.insert(record)

        do {
            try modelContext?.save()
        } catch {
            print("❌ Failed to save CP record: \(error)")
        }

        controlPause = 0

        Task {
            await fetchSavedHistory()
        }
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
        DispatchQueue.main.async {
            self.synthesizer.stopSpeaking(at: .immediate)
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-AU")
            utterance.rate = AVSpeechUtteranceDefaultSpeechRate * 0.7
            utterance.pitchMultiplier = 1.1
            self.synthesizer.speak(utterance)
        }
    }

  
    deinit {
        stopTimers()
    }
}
