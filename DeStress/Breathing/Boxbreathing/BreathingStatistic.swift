//
//  BreathingStatistic.swift
//  DeStress
//
//  Created by Eva Madarasz
//

import SwiftUI
import SwiftData

@Model
class BreathingStatistic {
    @Attribute var day: String
    @Attribute var cycles: Int

    init(day: String, cycles: Int) {
        self.day = day
        self.cycles = cycles
    }
}
