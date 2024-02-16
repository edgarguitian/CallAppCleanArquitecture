//
//  DialplanViewTests.swift
//  jokesphoneUITests
//
//  Created by Edgar Guitian Rey on 14/2/24.
//

import XCTest

final class DialplanViewTests: XCTestCase {

    private var app: XCUIApplication!
    private let identifierForEachDialplan = "forEachDialplan"
    private let identifierBtnPlayDialplan = "btnPlayDialplan"
    private let identifierToolbarDialplan = "toolbarDialplan"
    private let identifierNavDialplan = "navItemDialplan"
    private let identifierFooterDialplan = "footerDialplan"
    private let identifierNavigationDialplan = "navigationDialplan"
    private let identifierShopView = "textShopView"
    private let identifierConfigView = "textConfigView"
    private let identifierDetailView = "btnCallDialplanDetail"

    override func setUp() {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
    }

    func test_dialplan_view_screen_show() throws {
        let btnToolbar = app.buttons[identifierToolbarDialplan]
        let searchBar = app.searchFields["Search"]
        let fieldsDialplan = app.buttons[identifierForEachDialplan]
        let btnFooterShop = app.buttons[identifierFooterDialplan]
        let navigationDialplan = app.otherElements[identifierNavigationDialplan]

        XCTAssertTrue(navigationDialplan.waitForExistence(timeout: 5), app.debugDescription)
        XCTAssertTrue(btnToolbar.waitForExistence(timeout: 5), app.debugDescription)
        XCTAssertTrue(searchBar.waitForExistence(timeout: 5), app.debugDescription)
        XCTAssertTrue(fieldsDialplan.waitForExistence(timeout: 5), app.debugDescription)
        XCTAssertTrue(btnFooterShop.waitForExistence(timeout: 5), app.debugDescription)

    }

    func test_search_dialplan() throws {
        let searchBar = app.searchFields["Search"]
        XCTAssertTrue(searchBar.waitForExistence(timeout: 5), app.debugDescription)
        searchBar.tap()
        searchBar.typeText("Olor")
        let fieldsDialplan = app.buttons[identifierForEachDialplan]
        let btnBuscar = app.buttons["Search"]
        XCTAssert(btnBuscar.exists)
        btnBuscar.tap()
        XCTAssertTrue(fieldsDialplan.waitForExistence(timeout: 5), app.debugDescription)
        XCTAssertEqual(fieldsDialplan.buttons.count, 3)
    }

    func test_play_item_dialplan() throws {
        let fieldsDialplan = app.buttons[identifierForEachDialplan]
        XCTAssertTrue(fieldsDialplan.waitForExistence(timeout: 5), app.debugDescription)
        let btnPlay = app.buttons[identifierBtnPlayDialplan]
        XCTAssert(btnPlay.exists)
        let stackBtnsPlay = app.buttons.matching(identifier: identifierBtnPlayDialplan)
        let stackBtn = stackBtnsPlay.element(boundBy: 0)
        XCTAssert(stackBtn.exists)
        stackBtn.tap()
        let imageButton = stackBtn.label
        XCTAssertTrue(stackBtn.waitForExistence(timeout: 5), app.debugDescription)
        XCTAssertEqual(imageButton, "stop.circle.fill", imageButton)
        sleep(15)
        stackBtn.tap()

        XCTAssertEqual(stackBtn.label, "Play", app.debugDescription)
    }

    func test_go_shop() throws {
        let fieldShopView = app.staticTexts[identifierShopView]
        let btnFooterShop = app.buttons[identifierFooterDialplan]
        XCTAssertTrue(btnFooterShop.waitForExistence(timeout: 5), app.debugDescription)
        btnFooterShop.tap()
        XCTAssertTrue(fieldShopView.waitForExistence(timeout: 5), app.debugDescription)

    }

    func test_go_config() throws {
        let fieldConfigView = app.staticTexts[identifierConfigView]
        let btnToolbar = app.buttons[identifierToolbarDialplan]
        XCTAssertTrue(btnToolbar.waitForExistence(timeout: 5), app.debugDescription)
        btnToolbar.tap()
        XCTAssertTrue(fieldConfigView.waitForExistence(timeout: 5), app.debugDescription)

    }

    func test_go_dialplan_detail() throws {
        let fieldsDialplan = app.buttons[identifierForEachDialplan]
        XCTAssertTrue(fieldsDialplan.waitForExistence(timeout: 5), app.debugDescription)
        let stackItemsDialplan = app.buttons.matching(identifier: identifierForEachDialplan)
        let itemDialplan = stackItemsDialplan.element(boundBy: 0)
        XCTAssert(itemDialplan.exists)
        itemDialplan.tap()
        let viewDetail = app.buttons[identifierDetailView]
        XCTAssertTrue(viewDetail.waitForExistence(timeout: 5), app.debugDescription)
    }
}
