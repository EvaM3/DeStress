//
//  BreathingExerciseView.swift
//  DeStress
//
//

import SwiftUI


struct BreathingExerciseView: View {
    @ObservedObject var viewModel: BreathingExerciseViewModel

    var body: some View {
        ZStack {
            backgroundColorView()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()

                if viewModel.isCountdownActive {
                    Text("Starting in \(viewModel.countdown)...")
                        .font(.largeTitle)
                        .padding()
                        .onAppear {
                            viewModel.startCountdown()
                        }
                } else {
                    Text(viewModel.breathIn ? "Breathe In" : "Breathe Out")
                        .font(.largeTitle)
                        .padding()

                    ZStack {
                        Circle()
                            .trim(from: 0.0, to: viewModel.breathIn ? 1.0 : 0.0)
                            .stroke(Color("powderBlue"), lineWidth: 10)
                            .glow()
                            .frame(width: 300, height: 300)
                            .animation(.easeInOut(duration: viewModel.breathIn ? 4 : 6), value: viewModel.breathIn)
                    }
                }

                Spacer()

                Text("Time Left: \(viewModel.timeLeft) seconds")
                    .bold()
                    .padding()

                Button {
                    viewModel.resetExercise()
                    viewModel.startCountdown()
                } label: {
                    Text("Restart")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(width: 110, height: 50)
                        .foregroundColor(.white)
                        .background(Color("powderBlue"))
                        .cornerRadius(20)
                }
                .padding()
            }
            .foregroundColor(.white)
        }
        .onAppear {
            viewModel.requestHealthKitAuthorization()
        }
        .onDisappear {
            viewModel.stopExercise()
        }
    }
}
