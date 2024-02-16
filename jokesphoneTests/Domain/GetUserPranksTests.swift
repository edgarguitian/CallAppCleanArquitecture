//
//  GetUserPranksTests.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 15/2/24.
//

import XCTest
@testable import jokesphone
final class GetUserPranksTests: XCTestCase {

    func test_execute_sucesfully_returns_pranks() async throws {
        // GIVEN
        let userPranks = UserPrank.makeUserPranks()
        let result: Result<[UserPrank], JokesPhoneDomainError> = .success(userPranks)
        let stub = UserPranksRepositoryStub(result: result)
        let sut = GetUserPranks(repository: stub)

        // WHEN
        let capturedResult = await sut.execute()

        // THEN
        let capturedPranksResult = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(capturedPranksResult.count, userPranks.count)
        XCTAssertEqual(capturedPranksResult.first!.id, userPranks.first!.id)
        XCTAssertEqual(capturedPranksResult[1].id, userPranks[1].id)
        XCTAssertEqual(capturedPranksResult.last!.id, userPranks.last!.id)
        XCTAssertEqual(capturedPranksResult.first!.title, userPranks.first!.title)
        XCTAssertEqual(capturedPranksResult[1].title, userPranks[1].title)
        XCTAssertEqual(capturedPranksResult.last!.title, userPranks.last!.title)
        XCTAssertEqual(capturedPranksResult.first!.dial, userPranks.first!.dial)
        XCTAssertEqual(capturedPranksResult[1].dial, userPranks[1].dial)
        XCTAssertEqual(capturedPranksResult.last!.dial, userPranks.last!.dial)
        XCTAssertEqual(capturedPranksResult.first!.grabacion, userPranks.first!.grabacion)
        XCTAssertEqual(capturedPranksResult[1].grabacion, userPranks[1].grabacion)
        XCTAssertEqual(capturedPranksResult.last!.grabacion, userPranks.last!.grabacion)
    }

    func test_execute_returns_error_when_repository_returns_error() async throws {
        // GIVEN
        let result: Result<[UserPrank], JokesPhoneDomainError> = .failure(.generic)
        let stub = UserPranksRepositoryStub(result: result)
        let sut = GetUserPranks(repository: stub)

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

extension UserPrank {
    static func makeUserPranks() -> [UserPrank] {
        var result: [UserPrank] = []
        result.append(
            UserPrank(
                id: "1", dateNum: 0,
                returned: false, cou: "es",
                dateString: "antes", realDateString: "antes",
                title: "title1", grabacion: "grabacion1",
                dst: "dst1", name: "name1",
                dial: "dial1", done: true,
                visible: true,
                pic: "pic1",
                started: true,
                queued: false,
                uid: "uid1",
                gnt: false
            )
        )
        result.append(
            UserPrank(
                id: "2", dateNum: 0,
                returned: false, cou: "es",
                dateString: "ahora", realDateString: "ahora",
                title: "title2", grabacion: "grabacion2",
                dst: "dst2", name: "name2",
                dial: "dial2", done: true,
                visible: true,
                pic: "pic2",
                started: true,
                queued: false,
                uid: "uid2",
                gnt: false
            )
        )
        result.append(
            UserPrank(
                id: "3", dateNum: 0,
                returned: false, cou: "es",
                dateString: "despues", realDateString: "despues",
                title: "title3", grabacion: "grabacion3",
                dst: "dst3", name: "name3",
                dial: "dial3", done: true,
                visible: true,
                pic: "pic3",
                started: true,
                queued: false,
                uid: "uid3",
                gnt: false
            )
        )
        return result
    }

    static func makeUserPrankReturned() -> UserPrank {
        return UserPrank(
            id: "1",
            dateNum: 0,
            returned: true,
            cou: "es",
            dateString: "",
            realDateString: "",
            title: "titleReturned",
            grabacion: "",
            dst: "",
            name: "nameReturned",
            dial: "dialReturned",
            done: true,
            visible: true,
            pic: "picReturned",
            started: true,
            queued: false,
            uid: "uidReturned",
            gnt: false
        )
    }

    static func makeUserPrankSinEstado() -> UserPrank {
        return UserPrank(
            id: "1",
            dateNum: 0,
            returned: false,
            cou: "es",
            dateString: "",
            realDateString: "",
            title: "titleReturned",
            grabacion: "",
            dst: "",
            name: "nameReturned",
            dial: "dialReturned",
            done: true,
            visible: true,
            pic: "picReturned",
            started: true,
            queued: false,
            uid: "uidReturned",
            gnt: false
        )
    }

    static func makeUserPrankEnEjecucion() -> UserPrank {
        return UserPrank(
            id: "CuGGGr4CbEEa5Vlnlz",
            dateNum: 0,
            returned: false,
            cou: "es",
            dateString: "",
            realDateString: "",
            title: "titleReturned",
            grabacion: "",
            dst: "",
            name: "nameReturned",
            dial: "dialReturned",
            done: true,
            visible: true,
            pic: "picReturned",
            started: true,
            queued: false,
            uid: "uidReturned",
            gnt: false
        )
    }
}
