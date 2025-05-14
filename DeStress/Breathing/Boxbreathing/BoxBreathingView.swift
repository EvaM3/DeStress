
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
    @Query(sort: \BreathingStatistic.day, order: .reverse) private var statistics: [BreathingStatistic]
    
    @StateObject private var viewModel = BoxBreathingViewModel()
    @State private var isShowingDetail = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        VStack {
                            Button(action: {
                                withAnimation {
                                    isShowingDetail.toggle()
                                }
                            }) {
                                Image(systemName: "info.circle")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding()
                                    .accessibilityIdentifier("infoButton")
                            }

                            NavigationLink(destination: StatisticsView()) {
                                Image(systemName: "chart.bar")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding()
                                    .accessibilityIdentifier("statisticsButton")
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

                    Button(action: {
                        viewModel.toggleBreathing {
                            saveCycleForToday()
                        }
                    }) {
                        Text(viewModel.isBreathing ? "Stop Exercise" : "Start Exercise")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("powderBlue"))
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(
                    backgroundColorView()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                )

                if isShowingDetail {
                    DetailView(isShowingDetail: $isShowingDetail)
                        .transition(.opacity)
                        .zIndex(1)
                }
            }
        }
    }

    // MARK: - Data Saving
    private func saveCycleForToday() {
        let today = getCurrentDay()

        if let existing = statistics.first(where: { $0.day == today }) {
            existing.cycles += 1
            print("Updated existing record for \(today): \(existing.cycles)")
        } else {
            let newStat = BreathingStatistic(day: today, cycles: 1)
            modelContext.insert(newStat)
            print("Inserted new stat for \(today)")
        }

        do {
            try modelContext.save()
            print("Saved model context.")
        } catch {
            print("Error saving: \(error.localizedDescription)")
        }
    }

    private func getCurrentDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: Date())
    }
}

