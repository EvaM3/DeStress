//
//  SettingsView.swift
//  DeStress
//

//

import SwiftUI


struct SettingsView: View {
    @ObservedObject var settings: BreathingSettings

    var body: some View {
        Form {
            Section(header: Text("Breathing Pattern")) {
                VStack {
                    Text("Inhale Duration: \(Int(settings.inhaleDuration)) seconds")
                    Slider(value: $settings.inhaleDuration, in: 1...10, step: 1)
                }
                VStack {
                    Text("Exhale Duration: \(Int(settings.exhaleDuration)) seconds")
                    Slider(value: $settings.exhaleDuration, in: 1...10, step: 1)
                }
            }
        }
        .navigationBarTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settings: BreathingSettings())
    }
}
