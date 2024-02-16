//
//  MakeCallRepositoryTests.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 15/2/24.
//

import XCTest
@testable import jokesphone
final class MakeCallRepositoryTests: XCTestCase {

    func test_makeCall_returns_sucess() async throws {
        // GIVEN
        let makeCallResultDTO = MakeCallResultDTO.makeCallResult()
        let result: Result<(String, MakeCallResultDTO), HTTPClientError> = .success(makeCallResultDTO)
        let apiMakeCallStub = APIMakeCallDataSourceStub(result: result)
        let sut = MakeCallRepository(apiDataSource: apiMakeCallStub,
                                     errorMapper: JokesPhoneDomainErrorMapper(),
                                     callResultMapper: CallResultMapper())
        // WHEN
        let capturedResult = await sut.makeCall(title: "title1", dial: "dial1", dstCall: "dstCall1", name: "name1")

        // THEN
        let capturedCallResult = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(capturedCallResult.res, true)
        XCTAssertEqual(capturedCallResult.idCall, "idCall1")
    }

    func test_makeCall_returns_failure_when_makeCallDataSource_fails() async throws {
        // GIVEN
        let result: Result<(String, MakeCallResultDTO), HTTPClientError> = .failure(.generic)
        let apiMakeCallStub = APIMakeCallDataSourceStub(result: result)
        let sut = MakeCallRepository(apiDataSource: apiMakeCallStub,
                                     errorMapper: JokesPhoneDomainErrorMapper(),
                                     callResultMapper: CallResultMapper())
        // WHEN
        let capturedResult = await sut.makeCall(title: "title1", dial: "dial1", dstCall: "dstCall1", name: "name1")

        // THEN
        guard case .failure(let error) = capturedResult else {
            XCTFail("Expected failure, got success")
            return
        }

        XCTAssertEqual(error, JokesPhoneDomainError.generic)
    }

}

extension MakeCallResultDTO {
    static func makeCallResult() -> (String, MakeCallResultDTO) {
        return ("idCall1", MakeCallResultDTO(res: "OK", content: nil))
    }
}
