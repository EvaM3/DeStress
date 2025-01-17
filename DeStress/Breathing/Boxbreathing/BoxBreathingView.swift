
 // BoxBreathingView.swift
 // DeStress

 // Created by Eva Madarasz


import SwiftUI
import AVFoundation
import UIKit
import Charts
import SwiftData


struct BoxBreathingView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: BoxBreathingViewModel

    @State private var isShowingDetail: Bool = false

    init(context: ModelContext) {
        _viewModel = StateObject(wrappedValue: BoxBreathingViewModel(context: context))
    }

    var body: some View {
        ZStack {
            // Background
            Color("appBackground")
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                // MARK: Info and Statistics Buttons
                HStack {
                    Spacer()
                    VStack(spacing: 16) {
                        // Info Button
                        Button(action: {
                            withAnimation {
                                isShowingDetail.toggle()
                            }
                        }) {
                            InfoOrStatButton(icon: "info.circle", label: "Info")
                        }

                        // Statistics Button
                        NavigationLink(destination: StatisticsView()) {
                            InfoOrStatButton(icon: "chart.bar", label: "Stats")
                        }
                    }
                    .padding(.trailing)
                }
                .padding(.top)

                Spacer()

                // MARK: Main Content
                Text("Cycle: \(viewModel.cycleCount)")
                    .font(.headline)
                    .foregroundColor(.white)

                Text("Phase: \(viewModel.currentPhaseIndex + 1) of \(viewModel.totalPhases)")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 5)

                Circle()
                    .fill(Color(uiColor: viewModel.circleUIColor(for: viewModel.currentPhase)))
                    .frame(width: 200, height: 200)
                    .overlay(
                        Text("\(viewModel.secondsRemaining) seconds")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                    )

                Text(viewModel.currentPhase)
                    .font(.title)
                    .bold()
                    .foregroundColor(Color(uiColor: viewModel.circleUIColor(for: viewModel.currentPhase)))

                Spacer()

                // Start/Stop Exercise Button
                Button(action: viewModel.toggleBreathing) {
                    BreathingActionButton(
                        title: viewModel.isBreathing ? "Stop Exercise" : "Start Exercise",
                        color: Color("powderBlue")
                    )
                }
            }
            .padding()

            // MARK: Detail View
            if isShowingDetail {
                DetailView(isShowingDetail: $isShowingDetail)
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
        .navigationTitle("Box Breathing")
        .navigationBarTitleDisplayMode(.inline)
    }
}
