//
//  SplashViewTests.swift
//  jokesphoneUITests
//
//  Created by Edgar Guitian Rey on 14/2/24.
//

import XCTest

final class SplashViewTests: XCTestCase {

    private var app: XCUIApplication!
    private let identifierLoadingSplash = "loadingSplash"
    private let identifierNavigationDialplan = "navigationDialplan"
    override func setUp() {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments += ["UITestLoadingHandling"]
        app.launch()
    }

    override func tearDown() {
        app = nil
    }

    func test_splash_view_screen_show() throws {
        print(app.debugDescription)
        let loadingSplash = app.otherElements[identifierLoadingSplash]
        XCTAssert(loadingSplash.exists)
        let navigationDialplan = app.otherElements[identifierNavigationDialplan]
        XCTAssertTrue(navigationDialplan.waitForExistence(timeout: 10), app.debugDescription)

    }
}
