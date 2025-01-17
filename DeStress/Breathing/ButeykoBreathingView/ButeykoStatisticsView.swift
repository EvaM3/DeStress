//
//  ButeykoStatisticsView.swift
//  DeStress
//
//  Created by Eva Madarasz
//

import SwiftUI
import Charts

struct ButeykoStatisticsView: View {
    @StateObject private var viewModel = ButeykoBreathingViewModel()

    var body: some View {
        VStack {
            Text("CP History Statistics")
                .font(.largeTitle)
                .padding()

            if viewModel.controlPauseHistory.isEmpty {
                Text("No Control Pause data available")
                    .foregroundColor(.white)
                    .padding()
            } else {
                // Chart or maybe List(?) for CP History
                Chart {
                    ForEach(Array(viewModel.controlPauseHistory.enumerated()), id: \.offset) { index, cp in
                        BarMark(
                            x: .value("Session", index + 1),
                            y: .value("Control Pause (s)", cp)
                        )
                        .foregroundStyle(Color("powderBlue"))
                    }
                }
                .frame(height: 250)
                .padding()
                .background(Color("appBackground").opacity(0.9))
                .cornerRadius(10)

                Spacer()

                Text("Control Pause History:")
                    .font(.title2.weight(.semibold))
                    .padding()

                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(Array(viewModel.controlPauseHistory.enumerated()), id: \.offset) { index, cp in
                            Text("Session \(index + 1): \(cp) seconds")
                                .font(.body)
                                .padding(.vertical, 4)
                                .padding(.horizontal)
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(8)
                                .padding(.horizontal)
                        }
                    }
                }
                .frame(maxHeight: 200)
            }
        }
        .padding()
        .background(Color("appBackground").edgesIgnoringSafeArea(.all))
        .navigationTitle("CP Statistics")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    ButeykoStatisticsView()
}