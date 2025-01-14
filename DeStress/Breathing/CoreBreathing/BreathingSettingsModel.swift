//
//  BreathingSettingsModel.swift
//  DeStress
//
//  Created by Eva Madarasz 
//

import UIKit
import Combine

class BreathingSettings: ObservableObject {
    @Published var inhaleDuration: Double = 4
    @Published var exhaleDuration: Double = 4
}
