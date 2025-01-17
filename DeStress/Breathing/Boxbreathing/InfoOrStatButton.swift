//
//  InfoOrStatButton.swift
//  DeStress
//
//  Created by Eva Sira Madarasz on 17/01/2025.
//

import SwiftUI

struct InfoOrStatButton: View {
    let icon: String
    let label: String

    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.white)
                .padding()

            Text(label)
                .font(.caption)
                .foregroundColor(.white)
        }
        .frame(width: 80, height: 80)
        .cornerRadius(10)
    }
}
