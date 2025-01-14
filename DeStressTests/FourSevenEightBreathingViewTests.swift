//
//  FourSevenEightBreathingViewTests.swift
//  DeStressTests
//
//  Created by Eva Madarasz on 11/11/2024.
//

import XCTest
import SwiftUI
@testable import DeStress



class FourSevenEightBreathingViewModelTests: XCTestCase {
    var viewModel: FourSevenEightBreathingViewModel!

    override func setUpWithError() throws {
        viewModel = FourSevenEightBreathingViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    // Initial state of ViewModel
    func testInitialState() {
        XCTAssertEqual(viewModel.breathPhase, "Inhale", "Initial breath phase should be 'Inhale'")
        XCTAssertEqual(viewModel.breathOpacity, 1.0, "Initial breath opacity should be 1.0")
        XCTAssertEqual(viewModel.breathSize, 1.0, "Initial breath size should be 1.0")
        XCTAssertEqual(viewModel.cycleCount, 0, "Initial cycle count should be 0")
        XCTAssertFalse(viewModel.isBreathing, "Initial isBreathing state should be false")
        XCTAssertEqual(viewModel.countdown, 4, "Initial countdown should be 4")
    }

    // Starting the breathing cycle
    func testStartBreathingCycle() {
        viewModel.startBreathingCycle()

        XCTAssertTrue(viewModel.isBreathing, "isBreathing should be true after starting the breathing cycle")
        XCTAssertEqual(viewModel.breathPhase, "Inhale", "Breath phase should start with 'Inhale'")
        XCTAssertEqual(viewModel.countdown, Int(viewModel.inhaleDuration), "Countdown should match inhale duration when the cycle starts")
    }

    // Stopping the breathing cycle
    func testStopBreathingCycle() {
        viewModel.startBreathingCycle()
        viewModel.stopBreathingCycle()

        XCTAssertFalse(viewModel.isBreathing, "isBreathing should be false after stopping the breathing cycle")
        XCTAssertEqual(viewModel.breathPhase, "Inhale", "Breath phase should reset to 'Inhale' after stopping")
        XCTAssertEqual(viewModel.breathOpacity, 1.0, "Breath opacity should reset to 1.0 after stopping")
        XCTAssertEqual(viewModel.breathSize, 1.0, "Breath size should reset to 1.0 after stopping")
    }

    // Transitioning between phases
    func testNextBreathingPhase() {
        viewModel.startBreathingCycle()
        let expectation = XCTestExpectation(description: "Wait for phase transitions")

        DispatchQueue.main.asyncAfter(deadline: .now() + viewModel.inhaleDuration + 1) {
            XCTAssertEqual(self.viewModel.breathPhase, "Hold", "Breath phase should transition to 'Hold' after 'Inhale'")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: viewModel.inhaleDuration + 2)
    }

    // Countdown decrementing
    func testCountdownDecrements() {
        viewModel.startBreathingCycle()
        let expectation = XCTestExpectation(description: "Wait for countdown decrement")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertLessThan(self.viewModel.countdown, Int(self.viewModel.inhaleDuration), "Countdown should decrement during a phase")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

    // Cycle count increments
    func testCycleCountIncrements() {
        viewModel.startBreathingCycle()
        let expectation = XCTestExpectation(description: "Wait for one full cycle")

        let totalDuration = viewModel.inhaleDuration + viewModel.holdDuration + viewModel.exhaleDuration
        DispatchQueue.main.asyncAfter(deadline: .now() + totalDuration + 1) {
            XCTAssertEqual(self.viewModel.cycleCount, 1, "Cycle count should increment after one full cycle")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: totalDuration + 2)
    }

    // Speech synthesis
    func testSpeakFunction() {
        viewModel.speak("Test phrase")
        XCTAssertTrue(viewModel.synthesizer.isSpeaking, "Speech synthesizer should be speaking after calling speak()")
    }

    // Edge Case: Test stopping before starting
    func testStopBreathingBeforeStarting() {
        viewModel.stopBreathingCycle()
        XCTAssertFalse(viewModel.isBreathing, "isBreathing should remain false if stopping before starting")
        XCTAssertEqual(viewModel.breathPhase, "Inhale", "Breath phase should remain 'Inhale' when stopping before starting")
    }

    // Edge Case: Test rapid start and stop
    func testRapidStartAndStop() {
        viewModel.startBreathingCycle()
        viewModel.stopBreathingCycle()

        XCTAssertFalse(viewModel.isBreathing, "isBreathing should be false after rapid stop")
        XCTAssertEqual(viewModel.cycleCount, 0, "Cycle count should remain 0 after rapid start and stop")
    }

    // Edge Case: Test phase transition timing
    func testPhaseTransitionTiming() {
        viewModel.startBreathingCycle()
        let expectation = XCTestExpectation(description: "Wait for correct timing on phase transition")

        DispatchQueue.main.asyncAfter(deadline: .now() + viewModel.inhaleDuration) {
            XCTAssertEqual(self.viewModel.breathPhase, "Hold", "Breath phase should transition to 'Hold' after inhale duration")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: viewModel.inhaleDuration + 1)
    }
    
    func testStateResetOnStop() {
        viewModel.startBreathingCycle()
        viewModel.stopBreathingCycle()

        XCTAssertFalse(viewModel.isBreathing, "isBreathing should be false after stopping the breathing cycle")
        XCTAssertEqual(viewModel.breathPhase, "Inhale", "Breath phase should reset to 'Inhale'")
        XCTAssertEqual(viewModel.breathOpacity, 1.0, "Breath opacity should reset to 1.0")
        XCTAssertEqual(viewModel.breathSize, 1.0, "Breath size should reset to 1.0")
        XCTAssertEqual(viewModel.countdown, Int(viewModel.inhaleDuration), "Countdown should reset to inhale duration")
    }

    func testCountdownNeverNegative() {
        viewModel.startBreathingCycle()
        let expectation = XCTestExpectation(description: "Ensure countdown never goes negative")

        DispatchQueue.main.asyncAfter(deadline: .now() + viewModel.inhaleDuration + 1) {
            XCTAssertGreaterThanOrEqual(self.viewModel.countdown, 0, "Countdown should not go below zero during any phase")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: viewModel.inhaleDuration + 2)
    }
    

    func testSpeakInterruptions() {
        viewModel.speak("Test phrase 1")
        viewModel.speak("Test phrase 2")

        XCTAssertTrue(viewModel.synthesizer.isSpeaking, "Synthesizer should handle consecutive speak calls gracefully")
    }
    
    func testRapidStopAndStart() {
        viewModel.startBreathingCycle()
        viewModel.stopBreathingCycle()
        viewModel.startBreathingCycle()

        XCTAssertTrue(viewModel.isBreathing, "isBreathing should be true after restarting the breathing cycle")
        XCTAssertEqual(viewModel.breathPhase, "Inhale", "Breath phase should start at 'Inhale' after restarting")
    }

    func testTimerInvalidation() {
        viewModel.startBreathingCycle()
        viewModel.timer?.invalidate()

        XCTAssertFalse(viewModel.timer?.isValid ?? true, "Timer should be invalidated properly")
    }


}
