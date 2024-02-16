//
//  GetDialplanTests.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 14/2/24.
//

import XCTest
@testable import jokesphone
final class GetDialplanTests: XCTestCase {

    func test_execute_sucesfully_returns_dialplan() async throws {
        // GIVEN
        let dialplan = JokeDialplan.makeDialplan()
        let result: Result<[JokeDialplan], JokesPhoneDomainError> = .success(dialplan)
        let stub = DialplanRepositoryStub(result: result)
        let sut = GetDialplan(repository: stub)

        // WHEN
        let capturedResult = await sut.execute()

        // THEN
        let capturedDialplanResult = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(capturedDialplanResult.count, dialplan.count)
        XCTAssertEqual(capturedDialplanResult.first!.id, dialplan.first!.id)
        XCTAssertEqual(capturedDialplanResult[1].id, dialplan[1].id)
        XCTAssertEqual(capturedDialplanResult.last!.id, dialplan.last!.id)
        XCTAssertEqual(capturedDialplanResult.first!.audiofile, dialplan.first!.audiofile)
        XCTAssertEqual(capturedDialplanResult[1].audiofile, dialplan[1].audiofile)
        XCTAssertEqual(capturedDialplanResult.last!.audiofile, dialplan.last!.audiofile)
        XCTAssertEqual(capturedDialplanResult.first!.titulo, dialplan.first!.titulo)
        XCTAssertEqual(capturedDialplanResult[1].titulo, dialplan[1].titulo)
        XCTAssertEqual(capturedDialplanResult.last!.titulo, dialplan.last!.titulo)
    }

    func test_execute_returns_error_when_repository_returns_error() async throws {
        // GIVEN
        let result: Result<[JokeDialplan], JokesPhoneDomainError> = .failure(.generic)
        let stub = DialplanRepositoryStub(result: result)
        let sut = GetDialplan(repository: stub)

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

extension JokeDialplan {
    static func makeDialplan() -> [JokeDialplan] {
        var result: [JokeDialplan] = []
        result.append(
            JokeDialplan(
                id: "1",
                audiofile: "audioFile1",
                titulo: "titulo1",
                image: "image1",
                description: "desc1",
                example: "example1",
                hits: 0,
                enabled: true
            )
        )
        result.append(
            JokeDialplan(
                id: "2",
                audiofile: "audioFile2",
                titulo: "titulo2",
                image: "image2",
                description: "desc2",
                example: "example2",
                hits: 1,
                enabled: false
            )
        )
        result.append(
            JokeDialplan(
                id: "3",
                audiofile: "audioFile3",
                titulo: "titulo3",
                image: "image3",
                description: "desc3",
                example: "example3",
                hits: 2,
                enabled: true
            )
        )
        return result
    }
}
