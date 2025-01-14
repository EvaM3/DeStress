//
//  HealthKitManager.swift
//  DeStress
//
//  Created by Eva Sira Madarasz on 31/07/2024.
//

import Foundation
import HealthKit


class HealthKitManager {
    static let shared = HealthKitManager()
    private let healthStore = HKHealthStore()

    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            let error = NSError(domain: "HealthKit", code: 1, userInfo: [NSLocalizedDescriptionKey: "Health data not available on this device"])
            print("Health data not available: \(error.localizedDescription)")
            completion(false, error)
            return
        }

        guard let mindfulnessType = HKObjectType.categoryType(forIdentifier: .mindfulSession) else {
            let error = NSError(domain: "HealthKit", code: 2, userInfo: [NSLocalizedDescriptionKey: "Mindfulness type not available"])
            print("Mindfulness type not available: \(error.localizedDescription)")
            completion(false, error)
            return
        }

        let typesToShare: Set = [mindfulnessType]

        healthStore.requestAuthorization(toShare: typesToShare, read: nil) { success, error in
            if let error = error {
                print("Authorization error: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                completion(success, error)
            }
        }
    }

    func saveMindfulMinutes(startDate: Date, endDate: Date, completion: @escaping (Bool, Error?) -> Void) {
        guard let mindfulnessType = HKObjectType.categoryType(forIdentifier: .mindfulSession) else {
            let error = NSError(domain: "HealthKit", code: 2, userInfo: [NSLocalizedDescriptionKey: "Mindfulness type not available"])
            print("Mindfulness type not available: \(error.localizedDescription)")
            completion(false, error)
            return
        }

        let mindfulSession = HKCategorySample(type: mindfulnessType, value: 0, start: startDate, end: endDate)

        healthStore.save(mindfulSession) { success, error in
            if let error = error {
                print("Save error: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                completion(success, error)
            }
        }
    }
}
