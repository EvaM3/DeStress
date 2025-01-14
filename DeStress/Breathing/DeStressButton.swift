//
//  DeStressButton.swift
//  DeStress
//
//  Created by Eva  Madarasz
//

import SwiftUI

struct DeStressButton: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
            .frame(width: 260, height:50)
            .foregroundColor(.white)
            .background(Color("deepLilac"))
            .cornerRadius(10)
    }
}

#Preview {
    DeStressButton(title: "Button Test")
}
