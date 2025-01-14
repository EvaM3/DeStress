//
//  FourSevenEightBreathing_UITests.swift
//  DeStressUITests
//
//  Created by Eva Madarasz on 10/12/2024.
//

import XCTest

final class FourSevenEightBreathingViewUITests: XCTestCase {
    

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--ui-testing")
        app.launch()
    }
 

    func testInitialUIState() {
        
        XCTContext.runActivity(named: "Initial State Screenshot") { _ in
            let screenshot = app.screenshot()
            let attachment = XCTAttachment(screenshot: screenshot)
            attachment.lifetime = .keepAlways
            self.add(attachment)
        }
        // Verify: "Start Exercise" button exists
        let startButton = app.buttons["StartStopButton"]
        XCTAssertTrue(startButton.exists, "The Start Exercise button should be visible.")

        // Verify: Initial labels and cycle count are displayed
        let cycleLabel = app.staticTexts["Cycle: 0"]
        XCTAssertTrue(cycleLabel.exists, "The initial cycle count should be 0.")

        let phaseLabel = app.staticTexts["Inhale"]
        XCTAssertTrue(phaseLabel.exists, "The initial breathing phase should be 'Inhale'.")

        let countdownLabel = app.staticTexts["4"]
        XCTAssertTrue(countdownLabel.exists, "The initial countdown should be 4.")
    }

    func testStartAndStopBreathingCycle() {
        let startStopButton = app.buttons["StartStopButton"]
        XCTAssertTrue(startStopButton.exists, "The StartStopButton should exist initially.")

        // Check initial label text
        XCTAssertEqual(startStopButton.label, "Start Exercise", "Initially, the button should read 'Start Exercise'.")

  
        startStopButton.tap()

        // Verify that the button label changes to "Stop"
        XCTAssertEqual(startStopButton.label, "Stop", "After tapping, the button should read 'Stop'.")

       
        startStopButton.tap()
        XCTAssertEqual(startStopButton.label, "Start Exercise", "After tapping again, the button should revert to 'Start Exercise'.")
    }

    func testCircleAnimationState() {
        
        XCTContext.runActivity(named: "Circle Visible State Screenshot") { _ in
            let screenshot = app.screenshot()
            let attachment = XCTAttachment(screenshot: screenshot)
            attachment.lifetime = .keepAlways
            self.add(attachment)
        }

        // Start the breathing cycle
        let startStopButton = app.buttons["StartStopButton"]
        XCTAssertTrue(startStopButton.exists, "The StartStopButton should exist initially.")

        // Optional: Verify the initial label text
        XCTAssertEqual(startStopButton.label, "Start Exercise", "Initially, it should read 'Start Exercise'.")

        startStopButton.tap()

        // Verify: The circle's existence
        let circle = app.otherElements["BreathingCircle"]
        XCTAssertTrue(circle.waitForExistence(timeout: 5), "The animated breathing circle should be visible during the breathing cycle.")

  
    }

}
