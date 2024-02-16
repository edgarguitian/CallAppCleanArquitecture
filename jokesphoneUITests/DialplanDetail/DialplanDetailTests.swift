//
//  DialplanDetailTests.swift
//  jokesphoneUITests
//
//  Created by Edgar Guitian Rey on 15/2/24.
//

import XCTest

final class DialplanDetailTests: XCTestCase {

    private var app: XCUIApplication!
    private let identifierForEachDialplan = "forEachDialplan"
    private let identifierDetailBtnCall = "btnCallDialplanDetail"
    private let identifierDetailTitle = "detailTitle"
    private let identifierDetailContactInfo = "detailContactInfo"
    private let identifierDetailContactEditor = "detailContactEditor"
    private let identifierDetailRecordTitle = "detailRecordTitle"
    private let identifierDetailRecordToggle = "detailRecordToggle"
    private let identifierDetailRecordInfo = "detailRecordInfo"
    private let identifierDetailFooter = "footerDialplanDetail"

    private let identifierTabPranks = "tabUserPranks"
    private let identifierItemPrankTitle = "itemViewUserPrankTitle"

    override func setUp() {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
        go_dialplan_detail()
    }

    override func tearDown() {
        app = nil
    }

    func go_dialplan_detail() {
        let fieldsDialplan = app.buttons[identifierForEachDialplan]
        XCTAssertTrue(fieldsDialplan.waitForExistence(timeout: 5), app.debugDescription)
        let stackItemsDialplan = app.buttons.matching(identifier: identifierForEachDialplan)
        let itemDialplan = stackItemsDialplan.element(boundBy: Int.random(in: 0..<10))
        XCTAssert(itemDialplan.exists)
        itemDialplan.tap()
    }

    func test_dialplan_detail_view_screen_show() throws {
        let titleDetail = app.staticTexts[identifierDetailTitle]
        let contactInfoDetail = app.staticTexts[identifierDetailContactInfo]
        let contactEditorDetail = app.textViews[identifierDetailContactEditor]
        let recordTitleDetail = app.staticTexts[identifierDetailRecordTitle]
        let recordToggleDetail = app.switches[identifierDetailRecordToggle]
        let recordInfoDetail = app.staticTexts[identifierDetailRecordInfo]
        let footerDetail = app.buttons[identifierDetailFooter]
        let btnCallDetail = app.buttons[identifierDetailBtnCall]
        XCTAssertTrue(titleDetail.waitForExistence(timeout: 5), app.debugDescription)
        XCTAssert(contactInfoDetail.exists)
        XCTAssert(contactEditorDetail.exists)
        XCTAssert(recordTitleDetail.exists)
        XCTAssert(recordToggleDetail.exists)
        XCTAssert(recordInfoDetail.exists)
        XCTAssert(footerDetail.exists)
        XCTAssert(btnCallDetail.exists)
    }

    func test_dialplan_detail_make_call_fail() throws {
        let contactEditorDetail = app.textViews[identifierDetailContactEditor]
        XCTAssert(contactEditorDetail.exists)
        contactEditorDetail.tap()
        contactEditorDetail.typeText("+3499999999999999")
        let btnCallDetail = app.buttons[identifierDetailBtnCall]
        XCTAssert(btnCallDetail.exists)
        btnCallDetail.tap()
        let titleAlert = app.alerts.element.staticTexts["Error"]
        let btnAlert = app.alerts.element.buttons["OK"]
        XCTAssertTrue(btnAlert.waitForExistence(timeout: 5), app.debugDescription)
        XCTAssert(titleAlert.exists)
    }

    func test_dialplan_detail_make_call_success() throws {
        let contactEditorDetail = app.textViews[identifierDetailContactEditor]
        XCTAssert(contactEditorDetail.exists)
        contactEditorDetail.tap()
        contactEditorDetail.typeText("+34676768151")
        let btnCallDetail = app.buttons[identifierDetailBtnCall]
        XCTAssert(btnCallDetail.exists)
        btnCallDetail.tap()
        let titleAlert = app.alerts.element.staticTexts["Advertencia"]
        let btnAlert = app.alerts.element.buttons["OK"]
        XCTAssertTrue(btnAlert.waitForExistence(timeout: 5), app.debugDescription)
        XCTAssert(titleAlert.exists)
    }

    func test_dialplan_detail_random_make_call_and_check() throws {
        let contactEditorDetail = app.textViews[identifierDetailContactEditor]
        XCTAssert(contactEditorDetail.exists)
        contactEditorDetail.tap()
        contactEditorDetail.typeText("+34676768151")
        let btnCallDetail = app.buttons[identifierDetailBtnCall]
        XCTAssert(btnCallDetail.exists)
        btnCallDetail.tap()
        let titleAlert = app.alerts.element.staticTexts["Advertencia"]
        let titleDetail = app.staticTexts[identifierDetailTitle]
        let tagTitleDetail = titleDetail.value as? String
        print(tagTitleDetail!)
        let btnAlert = app.alerts.element.buttons["OK"]
        XCTAssertTrue(btnAlert.waitForExistence(timeout: 5), app.debugDescription)
        XCTAssert(titleAlert.exists)
        btnAlert.tap()
        let btnTabPranks = app.buttons[identifierTabPranks]
        XCTAssertTrue(btnTabPranks.waitForExistence(timeout: 5), app.debugDescription)
        btnTabPranks.tap()
        let itemsPranksTitle = app.staticTexts[identifierItemPrankTitle]
        XCTAssertTrue(itemsPranksTitle.waitForExistence(timeout: 5), app.debugDescription)
        let stackItemsPranks = app.staticTexts.matching(identifier: identifierItemPrankTitle)
        let stackFirstPrank = stackItemsPranks.element(boundBy: 0)
        XCTAssert(stackFirstPrank.exists)
        let tagFirstPrank = stackFirstPrank.value as? String
        print(tagFirstPrank!)
        XCTAssertEqual(tagTitleDetail, tagFirstPrank!)
    }
}
