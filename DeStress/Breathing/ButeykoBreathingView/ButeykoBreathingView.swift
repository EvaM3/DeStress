import SwiftUI
import SwiftData

struct ButeykoBreathingView: View {
  
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = ButeykoBreathingViewModel()

    var body: some View {
        TabView {
            mainView
                .tabItem {
                    Label("Breathing", systemImage: "lungs.fill")
                }
            
            ButeykoStatisticsView(viewModel: viewModel)

                .tabItem {
                    Label("CP History", systemImage: "chart.bar")
                }
            
            ButeykoDetailView()
                .tabItem {
                    Label("Learn More", systemImage: "info.circle")
                }
        }
        .accentColor(.gray)
        
        .task {
                   viewModel.setContext(modelContext)
                   await viewModel.fetchSavedHistory()
     }
    }

    var mainView: some View {
        ZStack {
            backgroundColorView()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
          

            VStack {
                Spacer()

                Text("Buteyko Breathing Method")
                    .font(.title.weight(.bold))
                    .padding()
                    .foregroundColor(Color("powderBlue"))

                if viewModel.isMeasuringCP {
                    Text("Control Pause: \(viewModel.controlPause) seconds")
                        .font(.title2.weight(.medium))
                        .padding()
                        .foregroundColor(.white)
                } else {
                    Text("Hold your breath in...")
                        .font(.title3.weight(.medium))
                        .foregroundColor(.white)
                        .padding()

                    Text("\(viewModel.countdown)")
                        .font(.system(size: 64, weight: .bold, design: .rounded))
                        .padding()
                        .foregroundColor(.white)
                        .onAppear(perform: viewModel.startCountdown)
                }

                HStack(spacing: 16) {
                    Button(action: viewModel.stopExercise) {
                        Text("Stop Exercise")
                            .font(.headline)
                            .padding()
                            .frame(width: 150, height: 80)
                            .background(Color.secondary)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Button(action: {
                        if viewModel.isBreathHeld {
                            viewModel.stopControlPauseMeasurement()
                        } else {
                            viewModel.startControlPauseMeasurement()
                        }
                        viewModel.isBreathHeld.toggle()
                    }) {
                        Text(viewModel.isBreathHeld ? "Stop Control Pause" : "Start Control Pause")
                            .font(.headline)
                            .padding()
                            .frame(width: 150, height: 80)
                            .background(viewModel.isBreathHeld ? Color("powderBlue") : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()

                Spacer()
            }
            .padding()
        }
    }
}





