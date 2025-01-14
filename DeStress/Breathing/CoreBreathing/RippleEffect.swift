//
//  RippleEffect.swift
//  DeStress
//
//  Created by Eva Madarasz on 12/07/2024.
//

import SwiftUI

struct RippleEffectView: View {
    @State private var ripple = false
    let circleColor: Color = Color("powderBlue")

    var body: some View {
        ZStack {
            Circle()
                .stroke(circleColor, lineWidth: 5)
                .scaleEffect(ripple ? 1.0 : 0.1)
                .opacity(ripple ? 0.0 : 1.0)
               
                .animation(Animation.easeOut(duration: 1.5).repeatForever(autoreverses: false))
                .onAppear {
                    ripple = true
                }
        }
        .frame(width: 200, height: 200)
    }
}

struct RippleEffectView_Previews: PreviewProvider {
    static var previews: some View {
        RippleEffectView()
    }
}

