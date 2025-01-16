//
//  FourSevenEightBreathingView.swift
//  DeStress
//
//  Created by Eva Madarasz 
//

import SwiftUI

struct FourSevenEightBreathingView: View {
    @StateObject private var viewModel = FourSevenEightBreathingViewModel()
  

    var body: some View {
        ZStack {
            VStack {
                Spacer()

                Text("Cycle: \(viewModel.cycleCount)")
                    .font(.headline)
                    .foregroundColor(.white)

                Text(viewModel.breathPhase)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 10)

                Text("\(viewModel.countdown)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.bottom, 50)

                Circle()
                    .fill(Color(uiColor: circleUIColor(for: viewModel.breathPhase)).opacity(viewModel.breathOpacity))
                    .frame(width: 200 * viewModel.breathSize, height: 200 * viewModel.breathSize)
                    .accessibilityIdentifier("BreathingCircle")
                    .accessibilityLabel("BreathingCircle")
                    .accessibilityElement()

                Spacer()

                Button(action: {
                    if viewModel.isBreathing {
                        viewModel.stopBreathingCycle()
                    } else {
                        viewModel.startBreathingCycle()
                    }
                }) {
                    Text(viewModel.isBreathing ? "Stop" : "Start Exercise")
                        .font(.title)
                        .padding()
                        .background(Color("powderBlue"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                }
                .accessibilityIdentifier("StartStopButton")
            }
            .background(
                Color("appBackground")
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            )
        }
    }

    func circleUIColor(for phase: String) -> UIColor {
        switch phase {
        case "Inhale":
            return UIColor(red: 0.68, green: 0.85, blue: 0.90, alpha: 1.0)
        case "Hold":
            return UIColor(red: 0.53, green: 0.81, blue: 0.92, alpha: 1.0)
        case "Exhale":
            return UIColor(red: 0.83, green: 0.83, blue: 0.83, alpha: 1.0)
        default:
            return UIColor(red: 0.68, green: 0.85, blue: 0.90, alpha: 1.0)
        }
    }
}
