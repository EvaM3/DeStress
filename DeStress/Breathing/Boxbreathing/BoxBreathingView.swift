
 // BoxBreathingView.swift
 // DeStress

 // Created by Eva Madarasz on 10/08/2024.

import SwiftUI
import AVFoundation
import UIKit
import Charts



struct BoxBreathingView: View {
    @StateObject private var viewModel = BoxBreathingViewModel()
    @State private var isShowingDetail: Bool = false

    var body: some View {
        NavigationView {
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
                        
                            // Navigation to StatisticsView
                            NavigationLink(destination: StatisticsView()) {
                                Image(systemName: "chart.bar")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding()
                                    .accessibilityIdentifier("statisticsButton")
                            }
                           
                        }
                        .padding(.leading, 300)
                        Spacer() // Working!!!!!!
                 }


                    Text("Cycle: \(viewModel.cycleCount)")
                        .font(.headline)
                        .foregroundColor(.white)
                        .accessibilityIdentifier("cycleLabel")

                    Text("Phase: \(viewModel.currentPhaseIndex + 1) of \(viewModel.totalPhases)")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.top, 5)
                        .accessibilityIdentifier("phaseLabel")

                    Circle()
                        .fill(Color(uiColor: viewModel.circleUIColor(for: viewModel.currentPhase)))
                        .frame(width: 200, height: 200)
                        .overlay(
                            Text("\(viewModel.secondsRemaining) seconds")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.white)
                                .accessibilityIdentifier("secondsLabel")
                        )

                    Text(viewModel.currentPhase)
                        .font(.title)
                        .bold()
                        .foregroundColor(Color(uiColor: viewModel.circleUIColor(for: viewModel.currentPhase)))
                        .accessibilityIdentifier("currentPhaseLabel")

                    Spacer()

                    Button(action: viewModel.toggleBreathing) {
                        Text(viewModel.isBreathing ? "Stop Exercise" : "Start Exercise")
                            .foregroundColor(.white)
                            .padding()
                            .background(viewModel.isBreathing ? Color("powderBlue") : Color("powderBlue"))
                            .cornerRadius(10)
                            .accessibilityIdentifier("toggleBreathingButton")
                    }
                }
                .padding()
                .background(
                    Color("appBackground")
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                )

                // Use DetailView
                if isShowingDetail {
                    DetailView(isShowingDetail: $isShowingDetail)
                        .transition(.opacity)
                        .zIndex(1)
                        .accessibilityIdentifier("detailView") 
                }
            }
        }
    }
}


