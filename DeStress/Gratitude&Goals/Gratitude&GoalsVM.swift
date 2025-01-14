//
//  Gratitude&GoalsVM.swift
//  DeStress
//
//  Created by Eva Madarasz 
//

import SwiftUI

class GratitudeGoalsViewModel: ObservableObject {
    @Published var gratitudeItems: [GratitudeItem] = []
    @Published var goalItems: [GoalItem] = []
}


