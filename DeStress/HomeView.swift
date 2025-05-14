//
//  HomeView.swift
//  DeStress
//
//  Created by Eva Madarasz 
//


import SwiftUI
import SwiftData

struct HomeView: View {
  @Environment(\.modelContext) private var context
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColorView()
               // Color("appBackground")
                    .blur(radius: 20)
                    .edgesIgnoringSafeArea(.all)
    
                VStack(spacing: 20) {
                    Spacer()

                    // MARK: One minute breathing
                    NavigationLink(destination: BreathingExerciseView(viewModel: BreathingExerciseViewModel(context: context))) {
                        HomeButton(title: "Calm down with breathing", systemImage: "wind")
                    }
                    .padding(.bottom, 40)

                    // MARK: 4-7-8 breathing
                    NavigationLink(destination: FourSevenEightBreathingView()) {
                        HomeButton(title: "4-7-8 breathing relaxation", systemImage: "lungs")
                    }
                    .padding(.bottom, 40)
                    
                    // MARK: Box breathing
                    NavigationLink(destination: BoxBreathingView()) {
                        HomeButton(title: "Box breathing", systemImage: "square.grid.2x2")
                    }
                    .padding(.bottom, 40)
                    
                    // MARK: Buteyko breathing
                    NavigationLink(destination: ButeykoBreathingView()) {
                        HomeButton(title: "Buteyko Breathing Method", systemImage: "waveform.path.ecg")
                    }


                    .padding(.bottom, 40)
                    
                    // MARK: Goals and gratitude
                    NavigationLink(destination: GratitudeGoalsView()) {
                        HomeButton(title: "Set goals and be grateful", systemImage: "sparkle.magnifyingglass")
                    }

                    Spacer()
                }
                .padding(.bottom, 50)
            }
        }
        .navigationBarHidden(true)
    }
}

struct HomeButton: View {
    let title: String
    let systemImage: String

    var body: some View {
        HStack {
                 Image(systemName: systemImage)
                     .font(.title2)
                     .foregroundColor(.white)
                 Text(title)
                     .font(.title3)
                     .foregroundColor(.white)
                     .multilineTextAlignment(.center)
                     .lineLimit(nil)
                                     .fixedSize(horizontal: false, vertical: true)
             }
             .padding()
             .frame(width: 290, height: 60)
             .background(Color("powderBlue"))
             .cornerRadius(10)
         }
    }


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

