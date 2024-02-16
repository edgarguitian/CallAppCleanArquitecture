//
//  JokesPhonePresentableErrorMapperTests.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 16/2/24.
//

import XCTest
@testable import jokesphone

class JokesPhonePresentableErrorMapperTests: XCTestCase {

    func test_map_errornil() {
        // GIVEN
        let errorMapper = JokesPhonePresentableErrorMapper()

        // WHEN
        let result = errorMapper.map(error: nil)

        // THEN
        XCTAssertEqual(result, "Something went wrong")
    }

    func test_map_errornotnil() {
        // GIVEN
        let errorMapper = JokesPhonePresentableErrorMapper()

        // WHEN
        let result = errorMapper.map(error: JokesPhoneDomainError.generic)

        // THEN
        XCTAssertEqual(result, "Something went wrong")
    }

}
