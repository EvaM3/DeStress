//
//  GlowView.swift
//  DeStress
//

//

import SwiftUI

struct GlowView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
            
                
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                    .font(.system(size: 100))
                    .glow()
            }
                
        }
    }
}


struct Glow: ViewModifier {
    @State private var pulse = false
    func body(content: Content) -> some View{
        ZStack {
            content
                .blur(radius: pulse ? 20 : 8)
                .animation(.easeOut(duration: 0.5).repeatForever(), value: pulse)
                .onAppear {
                    pulse.toggle()
                }
            
            content
        }
    }
}

extension View {
    func glow() -> some View {
        modifier(Glow())
    }
}

struct GlowView_Previews: PreviewProvider {
    static var previews: some View {
        GlowView()
    }
}
