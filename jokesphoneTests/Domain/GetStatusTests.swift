//
//  GetStatusTests.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 14/2/24.
//

import XCTest
@testable import jokesphone
final class GetStatusTests: XCTestCase {

    func test_execute_sucesfully_returns_status() async throws {
        // GIVEN
        let userStatus = UserStatus.makeUserStatus()
        let result: Result<UserStatus, JokesPhoneDomainError> = .success(userStatus)
        let stub = UserStatusRepositoryStub(result: result)
        let sut = GetStatus(repository: stub)

        // WHEN
        let capturedResult = await sut.execute()

        // THEN

        let capturedStatusResult = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(capturedStatusResult.res, userStatus.res)
        XCTAssertEqual(capturedStatusResult.version, userStatus.version)
        XCTAssertEqual(capturedStatusResult.joinIos, userStatus.joinIos)
        XCTAssertEqual(capturedStatusResult.shareURL, userStatus.shareURL)

    }

    func test_execute_returns_error_when_repository_returns_error() async throws {
        // GIVEN
        let result: Result<UserStatus, JokesPhoneDomainError> = .failure(.generic)
        let stub = UserStatusRepositoryStub(result: result)
        let sut = GetStatus(repository: stub)

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

extension UserStatus {
    static func makeUserStatus() -> UserStatus {
        return UserStatus(res: "OK",
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
