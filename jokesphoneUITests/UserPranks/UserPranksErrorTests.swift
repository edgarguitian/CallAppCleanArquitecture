//
//  UserPranksErrorTests.swift
//  jokesphoneUITests
//
//  Created by Edgar Guitian Rey on 15/2/24.
//

import XCTest

final class UserPranksErrorTests: XCTestCase {

    private var app: XCUIApplication!
    private let identifierTabPranks = "tabUserPranks"

    override func setUp() {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments += ["UITestErrorHandlingUserPranks"]

        app.launch()
    }

    override func tearDown() {
        app = nil
    }

    func test_userPranks_view_screen_show() throws {
        let btnTabPranks = app.buttons[identifierTabPranks]
        XCTAssert(btnTabPranks.exists)
        btnTabPranks.tap()
        let btnAlert = app.alerts.element.buttons["OK"]
        XCTAssert(btnAlert.waitForExistence(timeout: 5), app.debugDescription)

    }
}
