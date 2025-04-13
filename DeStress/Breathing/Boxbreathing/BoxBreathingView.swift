
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

          init(context: ModelContext) {
              _viewModel = StateObject(wrappedValue: BoxBreathingViewModel(context: context))
          }
    
       @State private var isShowingDetail: Bool = false
    

    @Query(sort: \BreathingStatistic.day, order: .reverse) private var statistics: [BreathingStatistic]


    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        Spacer()

                        VStack {
                            // Info Button
                        
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

                            // Statistics Button
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
                        viewModel.toggleBreathing()
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

                // Detail View
                if isShowingDetail {
                    DetailView(isShowingDetail: $isShowingDetail)
                        .transition(.opacity)
                        .zIndex(1)
                }
            }
        }
    }
}
