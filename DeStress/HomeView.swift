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
       
        
        NavigationView {
            ZStack {
                Color("appBackground")
                    .blur(radius: 20)
                    .edgesIgnoringSafeArea(.all)


                VStack(spacing: 20) {
                    Spacer()

                    // MARK: One minute breathing
                    
                    NavigationLink(destination: BreathingExerciseView(viewModel: BreathingExerciseViewModel())) {
                        Text("Calm down with breathing")
                            .font(.title2)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 290, height: 60)
                            .background(Color("powderBlue"))
                            .cornerRadius(10)
                    }

                    .padding(.bottom, 40)
                    
                    // MARK: 4-7-8 breathing
                    
                    NavigationLink(destination: FourSevenEightBreathingView()) {
                        Text("4-7-8 breathing relaxation")
                            .font(.title2)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 290, height: 60)
                            .background(Color("powderBlue"))
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 40)
                    
                    // MARK: Box breathing
                    
                    NavigationLink(destination: BoxBreathingView(context: context)) {
                        Text("Box breathing")
                            .font(.title2)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 290, height: 60)
                            .background(Color("powderBlue"))
                            .cornerRadius(10)
                    }

                    .padding(.bottom, 40)
                    
                    // MARK: Buteyko breathing
                    
                    NavigationLink(destination: ButeykoBreathingView()) {
                        Text("Buteyko Breathing Method")
                            .font(.title2)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 290, height: 60) 
                            .background(Color("powderBlue"))
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 40)

                    // MARK: Goals and gratitude
                    
                    NavigationLink(destination: GratitudeGoalsView()) {
                        Text("Set goals and be grateful")
                            .font(.title2)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 290, height: 60)
                            .background(Color("powderBlue"))
                            .cornerRadius(10)
                    }

                    Spacer()
                }
                .padding(.bottom, 50)
            }
            .navigationBarHidden(true)  
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

