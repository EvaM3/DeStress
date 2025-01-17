//
//  BreathingActionButton.swift
//  DeStress
//
//  Created by Eva Madarasz
//

import SwiftUI

struct BreathingActionButton: View {
    let title: String
    let color: Color

    var body: some View {
        Text(title)
            .font(.headline)
            .padding()
            .frame(width: 200)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}
