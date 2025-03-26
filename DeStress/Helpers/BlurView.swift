//
//  BlurView.swift
//  DeStress
//
//  Created by Eva Madarasz
//

import SwiftUI

// UIKit blur wrapper - for the new(?) background
struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
