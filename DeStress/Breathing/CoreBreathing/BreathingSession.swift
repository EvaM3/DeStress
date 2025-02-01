//
//  BreathingSession.swift
//  DeStress
//
//  Created by Eva  Madarasz
//

import SwiftData
import Foundation

@Model
class BreathingSession {
    var id: UUID
    var date: Date
    var duration: Int
    var inhaleDuration: Double
    var exhaleDuration: Double

    init(duration: Int, inhaleDuration: Double, exhaleDuration: Double) {
        self.id = UUID()
        self.date = Date()
        self.duration = duration
        self.inhaleDuration = inhaleDuration
        self.exhaleDuration = exhaleDuration
    }
}

