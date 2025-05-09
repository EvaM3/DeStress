//
//  ControlPauseRecord.swift
//  DeStress
//
//  Created by Eva Madarasz
//

import Foundation
import SwiftData

@Model
class ControlPauseRecord {
    var timestamp: Date
    var duration: Int

    init(timestamp: Date = .now, duration: Int) {
        self.timestamp = timestamp
        self.duration = duration
    }
}

