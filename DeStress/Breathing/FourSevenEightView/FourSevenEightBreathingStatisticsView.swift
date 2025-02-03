//
//  FourSevenEightBreathingStatisticsView.swift
//  DeStress
//
//  Created by Eva Madarasz
//

import SwiftUI
import SwiftData

@Model
class BreathingStatistics: Identifiable {
    var id = UUID()
    var totalCycles: Int
    var totalDuration: Double // in seconds
    var averageCycleDuration: Double // in seconds
    var date: Date
    
    init(totalCycles: Int, totalDuration: Double, averageCycleDuration: Double, date: Date = Date()) {
        self.totalCycles = totalCycles
        self.totalDuration = totalDuration
        self.averageCycleDuration = averageCycleDuration
        self.date = date
    }
}

class BreathingStatisticsModel: ObservableObject {
    let container: ModelContainer
    @Published var statistics: [BreathingStatistics] = []
    
    init() {
        let schema = Schema([BreathingStatistics.self])
        container = try! ModelContainer(for: schema, configurations: [])
        Task { await loadStatistics() }
    }
    
    @MainActor func saveStatistics(totalCycles: Int, totalDuration: Double, averageCycleDuration: Double) {
        let newStat = BreathingStatistics(totalCycles: totalCycles, totalDuration: totalDuration, averageCycleDuration: averageCycleDuration)
        container.mainContext.insert(newStat)
        Task { await saveToDatabase() }
    }
    
    @MainActor private func saveToDatabase() async {
        try? await container.mainContext.save()
        await loadStatistics()
    }
    
    @MainActor private func loadStatistics() async {
        let fetchDescriptor = FetchDescriptor<BreathingStatistics>(sortBy: [SortDescriptor(\BreathingStatistics.date, order: .reverse)])
        statistics = (try? await container.mainContext.fetch(fetchDescriptor)) ?? []
    }
}

struct FourSevenEightBreathingStatisticsView: View {
    @ObservedObject var viewModel: FourSevenEightBreathingViewModel
    @StateObject var statisticsModel = BreathingStatisticsModel()
    
    var body: some View {
        VStack {
            Text("Breathing Statistics")
                .font(.title)
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.white)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Total Cycles:")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                    Text("\(viewModel.totalCycles)")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .padding()
                
                HStack {
                    Text("Total Duration:")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                    Text(String(format: "%.2f seconds", viewModel.totalDuration))
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .padding()
                
                HStack {
                    Text("Avg. Cycle Duration:")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                    Text(String(format: "%.2f seconds", viewModel.averageCycleDuration))
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .padding()
            }
            .background(Color("powderBlue").opacity(0.8))
            .cornerRadius(10)
            .padding()
            
            Spacer()
        }
        .background(
            Color("appBackground")
                .edgesIgnoringSafeArea(.all)
        )
        .onAppear {
            Task {
                await statisticsModel.saveStatistics(totalCycles: viewModel.totalCycles, totalDuration: viewModel.totalDuration, averageCycleDuration: viewModel.averageCycleDuration)
            }
        }
    }
}

struct FourSevenEightBreathingStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        FourSevenEightBreathingStatisticsView(viewModel: FourSevenEightBreathingViewModel())
    }
}
