//
//  Notifications.swift
//  DeStress
//
//

import Foundation
import UserNotifications

func scheduleNotification() {
    let content = UNMutableNotificationContent()
    content.title = "Time to Breathe"
    content.body = "Take a moment to practice your breathing exercises."
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: true)
    
    let request = UNNotificationRequest(identifier: "breathingReminder", content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("Error: \(error.localizedDescription)")
        }
    }
}
