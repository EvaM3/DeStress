//
//  StatisticsView.swift
//  DeStress
//
//  Created by Eva Madarasz
//

import SwiftUI
import Charts
import SwiftData


struct StatisticsView: View {
    @Query(sort: \BreathingStatistic.day, order: .reverse) private var statistics: [BreathingStatistic]
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Weekly Statistics")
                .font(.largeTitle)
                .padding(.top)
            
            if statistics.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "chart.bar.xaxis")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                    
                    Text("No Data Available")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text("Complete your first breathing session to see your progress here!")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                .padding()
            } else {
                Chart {
                    ForEach(statistics, id: \.day) { stat in
                        BarMark(
                            x: .value("Day", stat.day),
                            y: .value("Cycles", stat.cycles)
                        )
                        .foregroundStyle(Color("powderBlue"))
                        .annotation(position: .top) {
                            Text("\(stat.cycles)")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    }
                }
                .frame(height: 250)
                .padding()
                .background(Color("appBackground").opacity(0.9))
                .cornerRadius(10)
            }
            
            Spacer()
        }
        //        .onAppear {
        //            print("StatisticsView fetched: \(statistics)")
        //        }
        .navigationTitle("Statistics")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color("appBackground").edgesIgnoringSafeArea(.all))
    }
    
}



