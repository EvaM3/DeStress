//
//  ProgressView.swift
//  DeStress
//

//

import SwiftUI

struct ProgressView: View {
    @State private var sessionsCompleted = 10
    @State private var totalTimeSpent = 300 // in minutes
    
    var body: some View {
        VStack {
            Text("Sessions Completed: \(sessionsCompleted)")
                .font(.title)
                .padding()
            
            Text("Total Time Spent: \(totalTimeSpent) minutes")
                .font(.title)
                .padding()
        }
        .navigationBarTitle("Progress")
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}

