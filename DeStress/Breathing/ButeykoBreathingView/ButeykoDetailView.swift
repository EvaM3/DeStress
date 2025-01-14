//
//  ButeykoDetailView.swift
//  DeStress
//
//  Created by Eva Sira Madarasz on 12/11/2024.
//

import SwiftUI

struct ButeykoDetailView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("Buteyko Breathing Technique Details")
                    .font(.largeTitle.weight(.bold))
                    .padding()
                    .foregroundColor(.primary)

                Text("""
                    The Buteyko Breathing Method is a breathing technique that aims to normalize breathing patterns by reducing hyperventilation and increasing carbon dioxide levels in the blood. This can help improve overall health, especially for people with respiratory conditions like asthma or anxiety disorders.

                    ### Steps to Perform Buteyko Breathing:
                    1. Exhale slowly and hold your breath.
                    2. Use your index finger and thumb to plug your nose.
                    3. Hold your breath until you feel the urge to breathe, then inhale gently.
                    4. Breathe normally for at least 10 seconds.
                    5. Repeat the exercise several times, gradually increasing the duration.
                    """)
                    .font(.body)
                    .padding()
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 20)
            .padding()
        }
    }
}

