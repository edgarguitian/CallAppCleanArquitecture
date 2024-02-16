//
//  SplashViewErrorTests.swift
//  jokesphoneUITests
//
//  Created by Edgar Guitian Rey on 14/2/24.
//

import XCTest

final class SplashViewErrorTests: XCTestCase {

    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments += ["UITestErrorHandling"]

        app.launch()
    }

    override func tearDown() {
        app = nil
    }

    func test_splash_view_screen_show() throws {
        let btnAlert = app.alerts.element.buttons["OK"]
        XCTAssert(btnAlert.exists)

    }
}
