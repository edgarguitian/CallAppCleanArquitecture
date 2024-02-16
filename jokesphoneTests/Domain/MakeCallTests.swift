//
//  MakeCallTests.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 15/2/24.
//

import XCTest
@testable import jokesphone
final class MakeCallTests: XCTestCase {

    func test_execute_sucesfully_make_call() async throws {
        // GIVEN
        let makeCallResult = MakeCallResult.makeCallResult()
        let result: Result<MakeCallResult, JokesPhoneDomainError> = .success(makeCallResult)
        let stub = MakeCallRepositoryStub(result: result)
        let sut = MakeCall(repository: stub)

        // WHEN
        let capturedResult = await sut.execute(title: "title1", dial: "dial1", dstCall: "dstCall1", name: "name1")

        // THEN
        let capturedCallResult = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(capturedCallResult.res, makeCallResult.res)
    }

    func test_execute_returns_error_when_repository_returns_error() async throws {
        // GIVEN
        let result: Result<MakeCallResult, JokesPhoneDomainError> = .failure(.generic)
        let stub = MakeCallRepositoryStub(result: result)
        let sut = MakeCall(repository: stub)

        // WHEN
        let capturedResult = await sut.execute(title: "title1", dial: "dial1", dstCall: "dstCall1", name: "name1")

        // THEN
        guard case .failure(let error) = capturedResult else {
            XCTFail("Expected failure, got success")
            return
        }

        XCTAssertEqual(error, JokesPhoneDomainError.generic)
    }

}

extension MakeCallResult {
    static func makeCallResult() -> MakeCallResult {
        return MakeCallResult(res: true, content: nil, idCall: nil)
    }
}
