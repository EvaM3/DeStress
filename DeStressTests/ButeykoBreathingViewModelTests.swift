//
//  ButeykoBreathingViewTests.swift
//  DeStressTests
//
//  Created by Eva Sira Madarasz on 12/11/2024.
//

import XCTest
import SwiftUI
@testable import DeStress



final class ButeykoBreathingViewModelTests: XCTestCase {
    var viewModel: ButeykoBreathingViewModel!

    override func setUpWithError() throws {
        // Initialize a new instance of the VM before each test
        viewModel = ButeykoBreathingViewModel()
    }

    override func tearDownWithError() throws {
        // Deinitialize the VM after each test
        viewModel = nil
    }

    func testInitialState() {
        XCTAssertEqual(viewModel.countdown, 5, "Initial countdown should be 5.")
        XCTAssertFalse(viewModel.isBreathHeld, "isBreathHeld should initially be false.")
        XCTAssertEqual(viewModel.controlPause, 0, "Initial controlPause should be 0.")
        XCTAssertFalse(viewModel.isMeasuringCP, "isMeasuringCP should initially be false.")
        XCTAssertTrue(viewModel.controlPauseHistory.isEmpty, "controlPauseHistory should initially be empty.")
    }

    func testStartCountdown() {
        viewModel.startCountdown()
        XCTAssertEqual(viewModel.countdown, 5, "Countdown should initially start at 5.")
        XCTAssertFalse(viewModel.isBreathHeld, "isBreathHeld should remain false during countdown.")

        let expectation = XCTestExpectation(description: "Countdown reaches 1.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            XCTAssertEqual(self.viewModel.countdown, 1, "Countdown should decrement correctly.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }

    func testStartControlPauseMeasurement() {
        viewModel.startControlPauseMeasurement()
        XCTAssertTrue(viewModel.isMeasuringCP, "isMeasuringCP should be true when measuring starts.")
        XCTAssertEqual(viewModel.controlPause, 0, "Control pause should start at 0.")

        let expectation = XCTestExpectation(description: "Control pause increments.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertGreaterThan(self.viewModel.controlPause, 0, "Control pause should increment over time.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }

    func testStopControlPauseMeasurement() {
        viewModel.startControlPauseMeasurement()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewModel.stopControlPauseMeasurement()
            XCTAssertFalse(self.viewModel.isMeasuringCP, "isMeasuringCP should be false after stopping measurement.")
            XCTAssertEqual(self.viewModel.controlPauseHistory.count, 1, "Control pause should be added to history.")
            XCTAssertEqual(self.viewModel.controlPauseHistory.first, self.viewModel.controlPause, "Last control pause should match history.")
        }
    }

    func testStopExercise() {
        viewModel.startCountdown()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewModel.stopExercise()
            XCTAssertFalse(self.viewModel.isMeasuringCP, "isMeasuringCP should be false after stopping exercise.")
            XCTAssertFalse(self.viewModel.isBreathHeld, "isBreathHeld should be false after stopping exercise.")
            XCTAssertEqual(self.viewModel.countdown, 5, "Countdown should reset to 5 after stopping exercise.")
            XCTAssertEqual(self.viewModel.controlPause, 0, "Control pause should reset to 0 after stopping exercise.")
        }
    }

    func testSpeakFunctionality() {
        // Test if the speak function can execute without crashing
        viewModel.startControlPauseMeasurement()
        viewModel.stopControlPauseMeasurement()
        // Verify speech synthesis doesn't crash.
    }
}
