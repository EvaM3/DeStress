//
//  Gratitude&GoalsModel.swift
//  DeStress
//
//  Created by Eva Madarasz
//

import SwiftUI

struct GratitudeItem: Identifiable {
    let id = UUID()
    var title: String
}

struct GoalItem: Identifiable {
    let id = UUID()
    var title: String
    var isAchieved: Bool = false
}
