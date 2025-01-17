//
//  BoxBreathingViewTests.swift
//  DeStressTests
//
//  Created by Eva Madarasz on 13/11/2024.


import XCTest
import SwiftUI
import SwiftData
@testable import DeStress


class BoxBreathingViewModelTests: XCTestCase {
    var viewModel: BoxBreathingViewModel!
    var testContext: ModelContext!

    @MainActor override func setUpWithError() throws {
        // Create an in-memory ModelContainer for testing
               let container = try ModelContainer(for: BreathingStatistic.self)
               testContext = container.mainContext

               // Initialize the view model with the test context
               viewModel = BoxBreathingViewModel(context: testContext)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testInitialState() {
        XCTAssertEqual(viewModel.currentPhaseIndex, 0)
        XCTAssertEqual(viewModel.cycleCount, 0)
        XCTAssertFalse(viewModel.isBreathing)
        XCTAssertEqual(viewModel.secondsRemaining, 4)
    }

    func testStartBreathingCycle() {
        viewModel.startBreathingCycle()
        XCTAssertTrue(viewModel.isBreathing)
        XCTAssertEqual(viewModel.currentPhase, "Inhale")
        XCTAssertEqual(viewModel.secondsRemaining, 4)
    }

    func testStopBreathingCycle() {
        viewModel.startBreathingCycle()
        viewModel.stopBreathingCycle()
        XCTAssertFalse(viewModel.isBreathing)
        XCTAssertEqual(viewModel.currentPhaseIndex, 0)
        XCTAssertEqual(viewModel.cycleCount, 0)
        XCTAssertEqual(viewModel.secondsRemaining, 4)
    }

    func testAdvancePhase() {
        viewModel.startBreathingCycle()
        viewModel.advancePhase()
        XCTAssertEqual(viewModel.currentPhaseIndex, 1)
        XCTAssertEqual(viewModel.currentPhase, "Hold")
    }

    func testCompleteCycle() {
        viewModel.startBreathingCycle()
        for _ in 0..<viewModel.totalPhases {
            viewModel.advancePhase()
        }
        XCTAssertEqual(viewModel.cycleCount, 1)
        XCTAssertEqual(viewModel.currentPhaseIndex, 0)
    }
    // MARK: New edge cases
    func testToggleBreathingStartsCycle() {
        viewModel.toggleBreathing()
        XCTAssertTrue(viewModel.isBreathing, "isBreathing should be true after toggling from stopped state")
        XCTAssertEqual(viewModel.currentPhase, "Inhale", "First phase should be 'Inhale'")
    }

    func testToggleBreathingStopsCycle() {
        viewModel.startBreathingCycle()
        viewModel.toggleBreathing()
        XCTAssertFalse(viewModel.isBreathing, "isBreathing should be false after toggling from started state")
        XCTAssertEqual(viewModel.currentPhaseIndex, 0, "Phase index should reset after stopping")
        XCTAssertEqual(viewModel.cycleCount, 0, "Cycle count should reset after stopping")
    }

    
    func testPhaseWrapAround() {
        viewModel.startBreathingCycle()
        for _ in 0..<viewModel.totalPhases {
            viewModel.advancePhase()
        }
        XCTAssertEqual(viewModel.currentPhaseIndex, 0, "Phase index should wrap around to 0 after completing a full cycle")
        XCTAssertEqual(viewModel.cycleCount, 1, "Cycle count should increment after completing a full cycle")
    }

    func testRapidStartAndStop() {
        viewModel.startBreathingCycle()
        viewModel.stopBreathingCycle()
        viewModel.startBreathingCycle()

        XCTAssertTrue(viewModel.isBreathing, "isBreathing should be true after restarting the breathing cycle")
        XCTAssertEqual(viewModel.currentPhase, "Inhale", "Phase should reset to 'Inhale' after restarting")
    }
    
    func testSecondsRemainingNeverNegative() {
        viewModel.startBreathingCycle()
        viewModel.secondsRemaining = 1
        viewModel.advancePhase()
        XCTAssertGreaterThanOrEqual(viewModel.secondsRemaining, 0, "Seconds remaining should not be negative after phase transition")
    }

    func testSpeakingConsecutivePhases() {
        viewModel.startBreathingCycle()
        for _ in 0..<viewModel.totalPhases {
            viewModel.advancePhase()
        }
        XCTAssertTrue(viewModel.synthesizer.isSpeaking, "Synthesizer should handle consecutive phase transitions correctly")
    }

}
