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

    var body: some View {
        NavigationStack {
            ZStack {
                Color("appBackground")
                    .blur(radius: 20)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Spacer()

                    // MARK: One minute breathing
                    NavigationLink(destination: BreathingExerciseView(viewModel: BreathingExerciseViewModel())) {
                        HomeButton(title: "Calm down with breathing")
                    }
                    .padding(.bottom, 40)

                    // MARK: 4-7-8 breathing
                    NavigationLink(destination: FourSevenEightBreathingView()) {
                        HomeButton(title: "4-7-8 breathing relaxation")
                    }
                    .padding(.bottom, 40)
                    
                    // MARK: Box breathing
                    NavigationLink(destination: BoxBreathingView(context: context)) {
                        HomeButton(title: "Box breathing")
                    }
                    .padding(.bottom, 40)
                    
                    // MARK: Buteyko breathing
                    NavigationLink(destination: ButeykoBreathingView()) {
                        HomeButton(title: "Buteyko Breathing Method")
                    }
                    .padding(.bottom, 40)
                    
                    // MARK: Goals and gratitude
                    NavigationLink(destination: GratitudeGoalsView()) {
                        HomeButton(title: "Set goals and be grateful")
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

    var body: some View {
        Text(title)
            .font(.title2)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
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

