//
//  UserPranksRepositoryTests.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 15/2/24.
//

import XCTest
@testable import jokesphone
final class UserPranksRepositoryTests: XCTestCase {

    func test_getUserPranks_returns_success_userPranks() async throws {
        // GIVEN
        let userPranksDTO = UserPrankDTO.makeUserPranks()
        let result: Result<[UserPrankDTO], HTTPClientError> = .success(userPranksDTO)
        let apiUserPranksStub = APIUserPranksDataSourceStub(result: result)
        let sut = UserPranksRepository(apiDataSource: apiUserPranksStub,
                                       errorMapper: JokesPhoneDomainErrorMapper(),
                                       userPranksResultMapper: UserPranksResultMapper())

        // WHEN
        let capturedResult = await sut.getUserPranks()

        // THEN
        let capturedPranksResult = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(capturedPranksResult.count, userPranksDTO.count)
        XCTAssertEqual(capturedPranksResult.first!.id, userPranksDTO.first!.id)
        XCTAssertEqual(capturedPranksResult[1].id, userPranksDTO[1].id)
        XCTAssertEqual(capturedPranksResult.last!.id, userPranksDTO.last!.id)
        XCTAssertEqual(capturedPranksResult.first!.title, userPranksDTO.first!.title)
        XCTAssertEqual(capturedPranksResult[1].title, userPranksDTO[1].title)
        XCTAssertEqual(capturedPranksResult.last!.title, userPranksDTO.last!.title)
        XCTAssertEqual(capturedPranksResult.first!.dial, userPranksDTO.first!.dial)
        XCTAssertEqual(capturedPranksResult[1].dial, userPranksDTO[1].dial)
        XCTAssertEqual(capturedPranksResult.last!.dial, userPranksDTO.last!.dial)
        XCTAssertEqual(capturedPranksResult.first!.grabacion, userPranksDTO.first!.grabacion)
        XCTAssertEqual(capturedPranksResult[1].grabacion, userPranksDTO[1].grabacion)
        XCTAssertEqual(capturedPranksResult.last!.grabacion, userPranksDTO.last!.grabacion)
    }

    func test_getUserPranks_returns_failure_when_userPranksDataSource_fails() async throws {
        // GIVEN
        let result: Result<[UserPrankDTO], HTTPClientError> = .failure(.generic)
        let apiUserPranksStub = APIUserPranksDataSourceStub(result: result)
        let sut = UserPranksRepository(apiDataSource: apiUserPranksStub,
                                       errorMapper: JokesPhoneDomainErrorMapper(),
                                       userPranksResultMapper: UserPranksResultMapper())

        // WHEN
        let capturedResult = await sut.getUserPranks()

        // THEN
        guard case .failure(let error) = capturedResult else {
            XCTFail("Expected failure, got success")
            return
        }

        XCTAssertEqual(error, JokesPhoneDomainError.generic)
    }

}

extension UserPrankDTO {
    static func makeUserPranks() -> [UserPrankDTO] {
        var result: [UserPrankDTO] = []
        result.append(UserPrankDTO(
                id: "1", dateNum: 0,
                returned: false, cou: "es",
                dateString: "antes", realDateString: "antes",
                title: "title1", grabacion: "grabacion1",
                dst: "dst1", name: "name1",
                dial: "dial1", done: true,
                visible: true, pic: "pic1",
                started: true,
                queued: false,
                uid: "uid1",
                gnt: false,
                rmv: false,
                amd: false,
                contestador: true))
        result.append(UserPrankDTO(
                id: "2", dateNum: 0,
                returned: false, cou: "es",
                dateString: "ahora", realDateString: "ahora",
                title: "title2", grabacion: "grabacion2",
                dst: "dst2", name: "name2",
                dial: "dial2", done: true,
                visible: true, pic: "pic2",
                started: true,
                queued: false,
                uid: "uid2",
                gnt: false,
                rmv: false,
                amd: false,
                contestador: true))
        result.append(UserPrankDTO(
                id: "3", dateNum: 0,
                returned: false, cou: "es",
                dateString: "despues", realDateString: "despues",
                title: "title3", grabacion: "grabacion3",
                dst: "dst3", name: "name3",
                dial: "dial3", done: true,
                visible: true, pic: "pic3",
                started: true,
                queued: false,
                uid: "uid3",
                gnt: false,
                rmv: false,
                amd: false,
                contestador: true))
        return result
    }
}
