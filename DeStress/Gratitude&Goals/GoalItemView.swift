//
//  GoalItemView.swift
//  DeStress
//
//  Created by Eva Madarasz
//

import Foundation
import SwiftUI

struct GoalItemView: View {
    var goal: GoalItem
    var toggleAchieved: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "target")
                .foregroundColor(goal.isAchieved ? .green : .purple)
            Text(goal.title)
                .font(.body)
            Spacer()
            Button(action: toggleAchieved) {
                Image(systemName: goal.isAchieved ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(goal.isAchieved ? .green : .gray)
                    .animation(.default, value: goal.isAchieved)
            }
        }
        .padding()
        .background(Color.purple.opacity(0.1))
        .cornerRadius(8)
    }
}

