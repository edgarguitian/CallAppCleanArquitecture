//
//  GetCreditTests.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 14/2/24.
//

import XCTest
@testable import jokesphone
final class GetCreditTests: XCTestCase {

    func test_execute_sucesfully_returns_credit() async throws {
        // GIVEN
        let userCredit = UserCredit.makeUserCredit()
        let result: Result<UserCredit, JokesPhoneDomainError> = .success(userCredit)
        let stub = UserCreditRepositoryStub(result: result)
        let sut = GetCredit(repository: stub)

        // WHEN
        let capturedResult = await sut.execute()

        // THEN
        let capturedCreditResult = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(capturedCreditResult.res, userCredit.res)
        XCTAssertEqual(capturedCreditResult.credit, userCredit.credit)
    }

    func test_execute_returns_error_when_repository_returns_error() async throws {
        // GIVEN
        let result: Result<UserCredit, JokesPhoneDomainError> = .failure(.generic)
        let stub = UserCreditRepositoryStub(result: result)
        let sut = GetCredit(repository: stub)

        // WHEN
        let capturedResult = await sut.execute()

        // THEN
        guard case .failure(let error) = capturedResult else {
            XCTFail("Expected failure, got success")
            return
        }

        XCTAssertEqual(error, JokesPhoneDomainError.generic)
    }
}

extension UserCredit {
    static func makeUserCredit() -> UserCredit {
        return UserCredit(res: "OK", credit: 20)
    }
}
