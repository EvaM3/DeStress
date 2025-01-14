//
//  BreathingStatistic.swift
//  DeStress
//
//  Created by Eva Madarasz
//

import Foundation
import SwiftData

@Model
class BreathingStatistic {
    @Attribute(.unique) var day: String
    var cycles: Int
    
    init(day: String, cycles: Int) {
        self.day = day
        self.cycles = cycles
    }
}
