//
//  StatisticsView.swift
//  DeStress
//
//  Created by Eva Madarasz on 16/11/2024.
//


import SwiftUI
import Charts
import SwiftData


struct StatisticsView: View {
    @Query(sort: \BreathingStatistic.day) private var statistics: [BreathingStatistic]

    var body: some View {
        VStack {
            Text("Weekly Statistics")
                .font(.largeTitle)
                .padding()

            if statistics.isEmpty {
                Text("No data available")
                    .foregroundColor(.white)
                    .padding()
            } else {
                // Render the Bar Chart
                Chart {
                    ForEach(statistics, id: \.day) { stat in
                        BarMark(
                            x: .value("Day", stat.day),
                            y: .value("Cycles", stat.cycles)
                        )
                        .foregroundStyle(Color("powderBlue"))
                    }
                }
                .frame(height: 200)
                .padding()
                .background(Color.red.opacity(0.5)) 
            }

            Spacer()
        }
       // .padding()
        .navigationTitle("Statistics")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color("appBackground").edgesIgnoringSafeArea(.all))
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        let container = try! ModelContainer(for: BreathingStatistic.self)
        return StatisticsView()
            .modelContainer(container)
            .onAppear {
                let context = container.mainContext
                let sampleData = [
                    BreathingStatistic(day: "Mon", cycles: 5),
                    BreathingStatistic(day: "Tue", cycles: 3),
                    BreathingStatistic(day: "Wed", cycles: 7),
                    BreathingStatistic(day: "Thu", cycles: 4),
                    BreathingStatistic(day: "Fri", cycles: 6)
                ]
                sampleData.forEach { context.insert($0) }
            }
    }
}
