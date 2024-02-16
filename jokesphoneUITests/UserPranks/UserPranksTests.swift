//
//  UserPranksTests.swift
//  jokesphoneUITests
//
//  Created by Edgar Guitian Rey on 15/2/24.
//

import XCTest

final class UserPranksTests: XCTestCase {

    private var app: XCUIApplication!
    private let identifierTabPranks = "tabUserPranks"
    private let identifierNavPranks = "navigationUserPranks"
    private let identifierFooterPranks = "footerUserPranks"
    private let identifierItemPrankTitle = "itemViewUserPrankTitle"
    private let identifierToolbarPranks = "toolbarUserPranks"
    private let identifierShopView = "textShopView"
    private let identifierConfigView = "textConfigView"
    private let identifierBtnPlayPrank = "btnPlayUserPrank"
    private let identifierBtnSharePrank = "btnShareUserPrank"
    private let springBoard = XCUIApplication(bundleIdentifier: "com.apple.springboard")

    override func setUp() {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
        goUserPranksView()
    }

    override func tearDown() {
        app = nil
    }

    func goUserPranksView() {
        let btnTabPranks = app.buttons[identifierTabPranks]
        XCTAssert(btnTabPranks.exists)
        btnTabPranks.tap()
    }

    func test_userPranks_view_screen_show() throws {

        let btnToolbar = app.buttons[identifierToolbarPranks]
        let btnFooterShop = app.buttons[identifierFooterPranks]
        let navigationPranks = app.otherElements[identifierNavPranks]
        let itemsPranksTitle = app.staticTexts[identifierItemPrankTitle]

        XCTAssertTrue(btnToolbar.waitForExistence(timeout: 5), app.debugDescription)
        XCTAssertTrue(btnFooterShop.waitForExistence(timeout: 5), app.debugDescription)
        XCTAssertTrue(navigationPranks.waitForExistence(timeout: 5), app.debugDescription)
        XCTAssertTrue(itemsPranksTitle.waitForExistence(timeout: 5), app.debugDescription)

    }

    func test_go_shop() throws {
        let fieldShopView = app.staticTexts[identifierShopView]
        let btnFooterShop = app.buttons[identifierFooterPranks]
        XCTAssertTrue(btnFooterShop.waitForExistence(timeout: 10), app.debugDescription)
        btnFooterShop.tap()
        XCTAssertTrue(fieldShopView.waitForExistence(timeout: 10), app.debugDescription)

    }

    func test_go_config() throws {
        let fieldConfigView = app.staticTexts[identifierConfigView]
        let btnToolbar = app.buttons[identifierToolbarPranks]
        XCTAssertTrue(btnToolbar.waitForExistence(timeout: 10), app.debugDescription)
        btnToolbar.tap()
        XCTAssertTrue(fieldConfigView.waitForExistence(timeout: 10), app.debugDescription)

    }

    func test_play_item_prank() throws {
        let btnPlay = app.buttons[identifierBtnPlayPrank]
        XCTAssertTrue(btnPlay.waitForExistence(timeout: 5), app.debugDescription)
        let stackBtnsPlay = app.buttons.matching(identifier: identifierBtnPlayPrank)
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

    func test_share_item_prank() throws {

        let btnShare = app.buttons[identifierBtnSharePrank]
        XCTAssertTrue(btnShare.waitForExistence(timeout: 5), app.debugDescription)
        print(app.debugDescription)
        let stackBtnsShare = app.buttons.matching(identifier: identifierBtnSharePrank)
        let stackBtn = stackBtnsShare.element(boundBy: 0)

        XCTAssert(stackBtn.exists)
        let hint = stackBtn.value as? String
        stackBtn.tap()
        sleep(5)
        let btnSave = app.staticTexts["Save to Files"]
        print(app.debugDescription)
        let textIdPrank = app.otherElements[hint!]
        XCTAssert(textIdPrank.exists)
        XCTAssert(btnSave.waitForExistence(timeout: 5), app.debugDescription)
    }
}
