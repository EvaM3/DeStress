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
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.clear
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        // UINavigationBar.appearance().tintColor = .white
    }
    
    var body: some Scene {
            WindowGroup {
                BoxBreathingView(context: try! ModelContainer(for: BreathingStatistic.self).mainContext)
                               .modelContainer(for: BreathingStatistic.self)
            }
        }
    }

