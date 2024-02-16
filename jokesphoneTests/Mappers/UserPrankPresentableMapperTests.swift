//
//  UserPrankPresentableMapperTests.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 16/2/24.
//

import XCTest
@testable import jokesphone

final class UserPrankPresentableMapperTests: XCTestCase {

    func test_map_empty_items() {
        // GIVEN
        let userPrankPresentableMapper = UserPrankPresentableMapper()

        // WHEN
        let result = userPrankPresentableMapper.map(items: [])

        // THEN
        XCTAssertTrue(result.isEmpty)
    }

    func test_map_not_empty_items() {
        // GIVEN
        let userPrankPresentableMapper = UserPrankPresentableMapper()
        let items = UserPrank.makeUserPranks()

        // WHEN
        let result = userPrankPresentableMapper.map(items: items)

        // THEN
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, UserPrankPresentableItem.makeUserPranksPresentable().count)
    }

    func test_getStateUserPrank_showButtons() {
        // GIVEN
        let userPrankPresentableMapper = UserPrankPresentableMapper()
        let items = UserPrank.makeUserPranks()

        // WHEN
        guard let userPrank = items.first else {
            XCTFail("No tenemos una userPrank")
            return
        }
        let result = userPrankPresentableMapper.getStateUserPrank(userPrank: userPrank)

        // THEN
        XCTAssertEqual(result, UserPrankState.showButtons)
    }

    func test_getStateUserPrank_noContestada() {
        // GIVEN
        let userPrankPresentableMapper = UserPrankPresentableMapper()
        let userPrankReturned = UserPrank.makeUserPrankReturned()

        // WHEN
        let result = userPrankPresentableMapper.getStateUserPrank(userPrank: userPrankReturned)

        // THEN
        XCTAssertEqual(result, UserPrankState.noContestada)
    }

    func test_getStateUserPrank_sinEstado() {
        // GIVEN
        let userPrankPresentableMapper = UserPrankPresentableMapper()
        let userPrankSinEstado = UserPrank.makeUserPrankSinEstado()

        // WHEN
        let result = userPrankPresentableMapper.getStateUserPrank(userPrank: userPrankSinEstado)

        // THEN
        XCTAssertEqual(result, UserPrankState.sinEstado)
    }

    func test_getStateUserPrank_enEjecucion() {
        // GIVEN
        let userPrankPresentableMapper = UserPrankPresentableMapper()
        let userPrankEnEjecucion = UserPrank.makeUserPrankEnEjecucion()

        // WHEN
        let result = userPrankPresentableMapper.getStateUserPrank(userPrank: userPrankEnEjecucion)

        // THEN
        XCTAssertEqual(result, UserPrankState.enEjecucion)
    }

    func test_buildUrlShare_not_empty() {
        // GIVEN
        let userPrankPresentableMapper = UserPrankPresentableMapper()
        let idToBuild = "exampleId"

        // WHEN
        let result = userPrankPresentableMapper.buildUrlShare(withId: idToBuild)

        // THEN
        var urlString = UserDefaultsManager.shared.shareURL ?? ""
        urlString.append(idToBuild)
        XCTAssertEqual(result?.absoluteString, urlString)
    }

    func test_buildUrlShare_empty() {
        // GIVEN
        let userPrankPresentableMapper = UserPrankPresentableMapper()

        // WHEN
        let result = userPrankPresentableMapper.buildUrlShare(withId: "")

        // THEN
        XCTAssertNil(result)
    }

}
