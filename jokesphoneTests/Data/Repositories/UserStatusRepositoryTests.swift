//
//  UserStatusRepositoryTests.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 14/2/24.
//

import XCTest
@testable import jokesphone

final class UserStatusRepositoryTests: XCTestCase {

    func test_getUserStatus_returns_success_status() async throws {
        // GIVEN
        let userStatusDTO = UserStatusDTO.makeUserStatusDTO()
        let result: Result<UserStatusDTO, HTTPClientError> = .success(userStatusDTO)

        let apiUserStatusStub = APIUserStatusDataSourceStub(result: result)
        let sut = UserStatusRepository(apiDataSource: apiUserStatusStub,
                                       errorMapper: JokesPhoneDomainErrorMapper(),
                                       userStatusResultMapper: UserStatusResultMapper())

        // WHEN
        let capturedResult = await sut.getUserStatus()

        // THEN
        let capturedStatusResult = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(capturedStatusResult.res, userStatusDTO.res)
        XCTAssertEqual(capturedStatusResult.version, userStatusDTO.version)
        XCTAssertEqual(capturedStatusResult.joinIos, userStatusDTO.joinIos)
        XCTAssertEqual(capturedStatusResult.shareURL, userStatusDTO.shareURL)
    }

    func test_getUserStatus_returns_failure_when_userStatusDataSource_fails() async throws {
        // GIVEN
        let result: Result<UserStatusDTO, HTTPClientError> = .failure(.generic)
        let apiUserStatusStub = APIUserStatusDataSourceStub(result: result)

        let sut = UserStatusRepository(apiDataSource: apiUserStatusStub,
                                       errorMapper: JokesPhoneDomainErrorMapper(),
                                       userStatusResultMapper: UserStatusResultMapper())

        // WHEN
        let capturedResult = await sut.getUserStatus()

        // THEN
        guard case .failure(let error) = capturedResult else {
            XCTFail("Expected failure, got success")
            return
        }
        XCTAssertEqual(error, JokesPhoneDomainError.generic)
    }

}

private extension UserStatusDTO {
    static func makeUserStatusDTO() -> UserStatusDTO {
        return UserStatusDTO(res: "OK",
                          version: 57,
                          banned: false,
                          admob: false,
                          hasPromo: false,
                          mgmMethod: "a",
                          showlegal: true,
                          country: "es",
                          joinIos: false,
                          registerIos: "register",
                          smsFirebaseIos: false,
                          recLocalIos: true,
                          showreactionIos: true,
                          mgmFreejokesUser: 0,
                          mgmFreejokesFriend: 1,
                          loginFbIos: false,
                          enabled: true,
                          amd: "full",
                          shareURL: "shareUrl")
    }
}
