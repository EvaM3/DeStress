//
//  DeStressApp.swift
//  DeStress
//
//  Created by Eva Sira Madarasz on 29/05/2024.
//

import SwiftUI
import SwiftData

@main

struct DeStressApp: App {
    init() {
        let appearance = UINavigationBarAppearance()

        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.backgroundEffect = nil

        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance

        UINavigationBar.appearance().tintColor = .white
    }

    
    var body: some Scene {
            WindowGroup {
                NavigationStack {
                    ContentView()
                }
                   .tint(.white)
                   .modelContainer(for: [BreathingStatistic.self])
            }
        }
    }

