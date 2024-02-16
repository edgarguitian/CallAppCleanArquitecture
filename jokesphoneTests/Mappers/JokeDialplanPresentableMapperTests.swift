//
//  JokeDialplanPresentableMapperTests.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 16/2/24.
//

import XCTest
@testable import jokesphone
final class JokeDialplanPresentableMapperTests: XCTestCase {

    func test_map_empty_items() {
        // GIVEN
        let jokeDialPresentableMapper = JokeDialplanPresentableMapper()

        // WHEN
        let result = jokeDialPresentableMapper.map(items: [])

        // THEN
        XCTAssertTrue(result.isEmpty)
    }

    func test_map_not_empty_items() {
        // GIVEN
        let jokeDialPresentableMapper = JokeDialplanPresentableMapper()
        let items = JokeDialplan.makeDialplan()

        // WHEN
        let result = jokeDialPresentableMapper.map(items: items)

        // THEN
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, JokeDialplanPresentableItem.makeDialplanPresentable().count)
    }

}
