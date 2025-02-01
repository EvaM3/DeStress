//
//  BreathingExerciseStatisticsView.swift
//  DeStress
//
//  Created by Eva Madarasz
//
import SwiftUI
import Charts
import SwiftData

struct BreathingExerciseStatisticsView: View {
    @Query private var sessions: [BreathingSession]

    var totalSessions: Int {
        sessions.count
    }

    var averageSessionDuration: Double {
        guard !sessions.isEmpty else { return 0 }
        return Double(sessions.map { $0.duration }.reduce(0, +)) / Double(sessions.count)
    }

    var averageInhaleDuration: Double {
        guard !sessions.isEmpty else { return 0 }
        return sessions.map { $0.inhaleDuration }.reduce(0, +) / Double(sessions.count)
    }

    var averageExhaleDuration: Double {
        guard !sessions.isEmpty else { return 0 }
        return sessions.map { $0.exhaleDuration }.reduce(0, +) / Double(sessions.count)
    }

    
    var body: some View {
        ZStack {
            Color("appBackground")
                .ignoresSafeArea()

            VStack {
                Text("Breathing Exercise Statistics")
                    .font(.largeTitle)
                    .padding()

                
                if sessions.isEmpty {
                    Text("No breathing session data available")
                        .foregroundColor(.white)
                        .padding()
                } else {
                    VStack(spacing: 20) {
                        Text("Total Sessions: \(totalSessions)")
                            .font(.title2.weight(.semibold))

                        Text("Average Session Duration: \(averageSessionDuration, specifier: "%.1f") sec")
                            .font(.body)

                        Text("Average Inhale: \(averageInhaleDuration, specifier: "%.1f") sec")
                            .font(.body)

                        Text("Average Exhale: \(averageExhaleDuration, specifier: "%.1f") sec")
                            .font(.body)

                        Chart {
                            ForEach(sessions.indices, id: \.self) { index in
                                BarMark(
                                    x: .value("Session", index + 1),
                                    y: .value("Duration", sessions[index].duration)
                                )
                                .foregroundStyle(Color("powderBlue"))
                            }
                        }
                        .frame(height: 250)
                        .padding()
                        .background(Color(.systemBackground).opacity(0.9))
                        .cornerRadius(10)
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Breathing Stats")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    BreathingExerciseStatisticsView()
}

