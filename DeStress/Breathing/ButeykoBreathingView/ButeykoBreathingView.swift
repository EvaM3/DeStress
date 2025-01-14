import SwiftUI

struct ButeykoBreathingView: View {
    @StateObject private var viewModel = ButeykoBreathingViewModel()

    var body: some View {
        
        TabView {
            mainView
            Spacer()
            
                .tabItem {
                    Label("Breathing", systemImage: "lungs.fill")
                }
            Spacer()
            ButeykoDetailView()
          
                .tabItem {
                    Label("Learn More", systemImage: "info.circle")
                        .padding(.trailing, 30)
                }
            Spacer()
        }
        .accentColor(.white)
    }

    var mainView: some View {
        ZStack {
            Color("appBackground")
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
                            .frame(width: 150)
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
                            .frame(width: 150)
                            .background(viewModel.isBreathHeld ? Color("powderBlue") : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()

                Spacer()

                if !viewModel.controlPauseHistory.isEmpty {
                    Text("Your CP History:")
                        .font(.title2.weight(.semibold))
                        .padding()
                        .foregroundColor(.primary)

                    ScrollView {
                        VStack(alignment: .leading) {
                            ForEach(viewModel.controlPauseHistory, id: \.self) { cp in
                                Text("\(cp) seconds")
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

                Spacer()
            }
            .padding()
        }
    }
}

