//
//  BoxBreathingViewUITests.swift
//  DeStressUITests
//
//  Created by Eva Madarasz
//

import XCTest
//
//final class BoxBreathingUITests: XCTestCase {
//    var app: XCUIApplication!
//
//    override func setUpWithError() throws {
//        continueAfterFailure = false
//        app = XCUIApplication()
//        app.launch()
//    }
//
//    override func tearDownWithError() throws {
//        app = nil
//    }
//
//    func testInitialUIState() {
//        let cycleLabel = app.staticTexts["cycleLabel"]
//
//        XCTAssertEqual(cycleLabel.label, "Cycle: 0", "Cycle count should start at 0.")
//
//        let phaseLabel = app.staticTexts["phaseLabel"]
//        XCTAssertTrue(phaseLabel.waitForExistence(timeout: 2), "Phase label should exist.")
//        XCTAssertEqual(phaseLabel.label, "Phase: 1 of 4", "Phase should start at 1 of 4.")
//
//        let currentPhaseLabel = app.staticTexts["currentPhaseLabel"]
//        XCTAssertTrue(currentPhaseLabel.waitForExistence(timeout: 2), "Current phase label should exist.")
//        XCTAssertEqual(currentPhaseLabel.label, "Inhale", "Initial phase should be 'Inhale'.")
//
//        let secondsLabel = app.staticTexts["secondsLabel"]
//        XCTAssertTrue(secondsLabel.waitForExistence(timeout: 2), "Seconds label should exist.")
//        XCTAssertEqual(secondsLabel.label, "4 seconds", "Timer should start at 4 seconds.")
//
//        let toggleBreathingButton = app.buttons["toggleBreathingButton"]
//        XCTAssertTrue(toggleBreathingButton.waitForExistence(timeout: 2), "Toggle button should be present.")
//    }
//
//    func testStartAndStopBreathingCycle() {
//        let toggleBreathingButton = app.buttons["toggleBreathingButton"]
//     
//        toggleBreathingButton.tap()
//
//        let currentPhaseLabel = app.staticTexts["currentPhaseLabel"]
//        XCTAssertTrue(currentPhaseLabel.waitForExistence(timeout: 2), "Current phase label should update after starting.")
//        XCTAssertEqual(currentPhaseLabel.label, "Inhale", "The first phase should be 'Inhale' after starting.")
//
//        toggleBreathingButton.tap()
//        XCTAssertEqual(currentPhaseLabel.label, "Inhale", "Phase should reset to 'Inhale' after stopping.")
//    }
//
//    func testPhaseTransitions() {
//        let toggleBreathingButton = app.buttons["toggleBreathingButton"]
//      
//
//        let phaseLabels = ["Inhale", "Hold", "Exhale", "Hold"]
//        for phase in phaseLabels {
//            let currentPhaseLabel = app.staticTexts["currentPhaseLabel"]
//            XCTAssertTrue(currentPhaseLabel.waitForExistence(timeout: 5), "Phase label should exist for \(phase).")
//            XCTAssertEqual(currentPhaseLabel.label, phase, "Phase label should display \(phase).")
//        }
//    }
//
//    func testDetailViewToggle() {
//        let infoButton = app.buttons["infoButton"]
//    
//        infoButton.tap()
//
//        let detailView = app.otherElements["detailView"]
//        XCTAssertTrue(detailView.waitForExistence(timeout: 2), "Detail view should appear when info button is tapped.")
//
//        infoButton.tap()
//        XCTAssertFalse(detailView.exists, "Detail view should disappear when info button is tapped again.")
//    }
//}




