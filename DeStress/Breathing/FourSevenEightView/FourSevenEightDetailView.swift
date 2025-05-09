//
//  FourSevenEightDetailView.swift
//  DeStress
//
//  Created by Eva Madarasz


import SwiftUI


struct FourSevenEightDetailView: View {
   
    @Binding var isShowingDetail: Bool

       var body: some View {
           VStack {
               ScrollView {
                   
                   VStack {
                    
                       Text("4-7-8 Breathing Technique Details")
                           .font(.largeTitle)
                           .fontWeight(.bold)
                           .padding()

                       Text("""
                           The 4-7-8 breathing technique, also known as the "relaxing breath," is a simple yet powerful exercise. It involves breathing in for 4 seconds, holding the breath for 7 seconds, and exhaling for 8 seconds. This technique can help reduce anxiety, manage cravings, control anger responses, and help you fall asleep faster.

                           1. Inhale quietly through your nose for 4 seconds.
                           2. Hold your breath for a count of 7 seconds.
                           3. Exhale completely through your mouth, making a whoosh sound, for 8 seconds.

                           Repeat this cycle up to four times. With practice, it can become more effective in promoting relaxation and calm.
                           """)
                           .font(.body)
                       
                       
                           .padding()
                           .multilineTextAlignment(.leading)
                     

                       Button(action: {
                           withAnimation {
                               isShowingDetail = false
                           }
                       }) {
                           Text("Close")
                               .font(.title2)
                               .padding()
                               .background(
                                   backgroundColorView()
                                       .scaledToFill()
                                       .edgesIgnoringSafeArea(.all))
                               .foregroundColor(.white)
                               .cornerRadius(10)
                       }
                       .padding()
                   }
               }
               .padding()
               
               .background(Color("powderBlue"))
               .foregroundColor(.white)
               .cornerRadius(20)
               .shadow(radius: 20)
               .padding()
           }
       }
    }


struct FourSevenEightDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FourSevenEightDetailView(isShowingDetail: .constant(true))
    }
}
