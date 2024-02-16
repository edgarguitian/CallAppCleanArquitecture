//
//  UserCreditRepositoryTests.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 14/2/24.
//

import XCTest
@testable import jokesphone
final class UserCreditRepositoryTests: XCTestCase {

    func test_getUserCredit_returns_sucess_credit() async throws {
        let userCreditDTO = UserCreditDTO.makeUserCredit()
        let result: Result<UserCreditDTO, HTTPClientError> = .success(userCreditDTO)
        let apiUserCreditStub = APIUserCreditDataSourceStub(result: result)
        let sut = UserCreditRepository(apiDataSource: apiUserCreditStub,
                                       errorMapper: JokesPhoneDomainErrorMapper(),
                                       userCreditResultMapper: UserCreditResultMapper())

        // WHEN
        let capturedResult = await sut.getUserCredit()

        // THEN
        let capturedCreditResult = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(capturedCreditResult.res, userCreditDTO.res)
        XCTAssertEqual(capturedCreditResult.credit, userCreditDTO.credit)
    }

    func test_getUserCredit_returns_failure_when_userCreditDataSource_fails() async throws {
        // GIVEN
        let result: Result<UserCreditDTO, HTTPClientError> = .failure(.generic)
        let apiUserCreditStub = APIUserCreditDataSourceStub(result: result)
        let sut = UserCreditRepository(apiDataSource: apiUserCreditStub,
                                       errorMapper: JokesPhoneDomainErrorMapper(),
                                       userCreditResultMapper: UserCreditResultMapper())

        // WHEN
        let capturedResult = await sut.getUserCredit()

        // THEN
        guard case .failure(let error) = capturedResult else {
            XCTFail("Expected failure, got success")
            return
        }

        XCTAssertEqual(error, JokesPhoneDomainError.generic)
    }
}

extension UserCreditDTO {
    static func makeUserCredit() -> UserCreditDTO {
        return UserCreditDTO(res: "OK", credit: 20)
    }
}
