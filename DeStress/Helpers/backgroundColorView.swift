//
//  backgroundColorView.swift
//  DeStress
//
//  Created by Eva Madarasz
//

import SwiftUI

struct backgroundColorView: View {
    var body: some View {
        ZStack {
               // Made for the possible background color change for the whole app
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.60, green: 0.52, blue: 0.78), // Muted Lavender
                        Color(red: 0.47, green: 0.38, blue: 0.64), // Dusty Purple
                        Color(red: 0.35, green: 0.28, blue: 0.55)  // Deep Plum
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                
                Color.white.opacity(0.01)
                    .background(
                        BlurView(style: .systemUltraThinMaterialLight)
                    )
                    .ignoresSafeArea()
            }
        }
      }


#Preview {
    backgroundColorView()
}
