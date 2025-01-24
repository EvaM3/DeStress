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
    
    var body: some Scene {
            WindowGroup {
                NavigationStack {
                    ContentView()
                               
                   .modelContainer(for: BreathingStatistic.self)
                    
                }
            }
        }
    }

