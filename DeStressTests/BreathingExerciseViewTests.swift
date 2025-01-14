//
//  BreathingExerciseViewTests.swift
//  DeStressTests
//
//  Created by Eva Madarasz on 16/11/2024.
//

import XCTest
@testable import DeStress

final class BreathingExerciseViewTests: XCTestCase {
    
    var viewModel: BreathingExerciseViewModel!

      override func setUp() {
          super.setUp()
          viewModel = BreathingExerciseViewModel()
      }

      func testCountdownStarts() {
          viewModel.startCountdown()

          XCTAssertTrue(viewModel.isCountdownActive, "Countdown should be active after starting")
          XCTAssertEqual(viewModel.countdown, 5, "Countdown should start from 5")
      }

    func testCountdownDecrements() {
        viewModel.startCountdown()

        let expectation = self.expectation(description: "Countdown decrements to zero")

        DispatchQueue.main.asyncAfter(deadline: .now() + 6.1) { // Allow for slight delay in timer
            XCTAssertEqual(self.viewModel.countdown, 0, "Countdown should reach zero after 5 seconds")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 7)
    }


      func testStopExercise() {
          viewModel.startExercise()
          viewModel.stopExercise()

          XCTAssertNil(viewModel.timer, "Timer should be nil after stopping exercise")
      }

      func testResetExercise() {
          viewModel.resetExercise()

          XCTAssertTrue(viewModel.breathIn, "Breathing should reset to inhale")
          XCTAssertEqual(viewModel.timeLeft, 60, "Time left should reset to 60 seconds")
          XCTAssertEqual(viewModel.countdown, 5, "Countdown should reset to 5")
      }

}
