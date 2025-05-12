//
//  ButeykoStatisticsView.swift
//  DeStress
//
//  Created by Eva Madarasz
//

import SwiftUI
import Charts
import SwiftData

struct ButeykoStatisticsView: View {
    @ObservedObject var viewModel: ButeykoBreathingViewModel

    init(viewModel: ButeykoBreathingViewModel) {
        self.viewModel = viewModel
    }


       var body: some View {
           ZStack {
               backgroundColorView()
                   .scaledToFill()
                   .edgesIgnoringSafeArea(.all)

               VStack {
                   Text("CP History Statistics")
                       .font(.largeTitle)
                       .padding()

                   if viewModel.controlPauseHistory.isEmpty {
                       Text("No Control Pause data available")
                           .foregroundColor(.white)
                           .padding()
                   } else {
                       Chart {
                           ForEach(Array(viewModel.controlPauseHistory.enumerated()), id: \.offset) { index, cp in
                               BarMark(
                                   x: .value("Session", index + 1),
                                   y: .value("Control Pause (s)", cp.duration)
                               )
                               .foregroundStyle(Color("powderBlue"))
                           }
                       }
                       .frame(height: 250)
                       .padding()
                       .background(Color(.systemBackground).opacity(0.9))
                       .cornerRadius(10)

                       Spacer()

                       Text("Control Pause History:")
                           .font(.title2.weight(.semibold))
                           .padding()

                       ScrollView {
                           VStack(alignment: .leading) {
                               ForEach(Array(viewModel.controlPauseHistory.enumerated()), id: \.offset) { index, cp in
                                   Text("Session \(index + 1): \(cp.duration) seconds")
                                       .font(.body)
                                       .padding()
                                       .background(Color(.secondarySystemBackground))
                                       .cornerRadius(8)
                                       .padding(.horizontal)
                               }
                               
                               Button(role: .destructive) {
                                   Task {
                                       await viewModel.clearHistory()
                                   }
                               } label: {
                                   Label("Clear History", systemImage: "trash")
                                       .font(.body.bold())
                                       .padding()
                                       .background(Color.red.opacity(0.8))
                                       .foregroundColor(.white)
                                       .cornerRadius(10)
                               }
                               .padding(.top)

                           }
                           Spacer()
                         
                       }
                       .frame(maxHeight: 200)
                   }
               }
               .padding(.leading, 20)
           }
           .task {
               await viewModel.fetchSavedHistory()
           }
           .navigationTitle("CP Statistics")
           .navigationBarTitleDisplayMode(.inline)
       }
}
