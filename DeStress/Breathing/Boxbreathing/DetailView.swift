//
//  DetailView.swift
//  DeStress
//
//  Created by Eva  Madarasz on 13/11/2024.


import SwiftUI

struct DetailView: View {
    @Binding var isShowingDetail: Bool

    var body: some View {
        ScrollView {
            VStack {
                Text("Box Breathing Technique Details")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                Text("""
                    Box breathing, also known as square breathing, is a simple yet powerful technique for improving concentration and relieving stress. It’s called box breathing because it consists of four equal parts, like a box: inhale, hold, exhale, and hold, each lasting for 4 seconds.

                    1. Inhale through your nose for 4 seconds.
                    2. Hold your breath for 4 seconds.
                    3. Exhale through your mouth for 4 seconds.
                    4. Hold your breath again for 4 seconds.

                    This technique is often used by athletes, Navy SEALs, and anyone looking to improve their performance under pressure.
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
                        .background(Color(red: 0.3, green: 0.5, blue: 0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 20)
            .padding()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(isShowingDetail: .constant(true))
    }
}
