//
//  DialplanRepositoryTests.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 14/2/24.
//

import XCTest
@testable import jokesphone
final class DialplanRepositoryTests: XCTestCase {

    func test_getDialplan_returns_sucess_dialplan() async throws {
        // GIVEN
        let dialplanDTO = JokeDialplanDTO.makeDialplan()
        let result: Result<[JokeDialplanDTO], HTTPClientError> = .success(dialplanDTO)
        let apiDialplanStub = APIDialplanDataSourceStub(result: result)
        let sut = DialplanRepository(apiDataSource: apiDialplanStub,
                                     errorMapper: JokesPhoneDomainErrorMapper(),
                                     dialplanMapper: DialplanMapper())

        // WHEN
        let capturedResult = await sut.getDialplan()

        // THEN
        let capturedDialplanResult = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(capturedDialplanResult.count, dialplanDTO.count)
        XCTAssertEqual(capturedDialplanResult.first!.id, dialplanDTO.first!.id)
        XCTAssertEqual(capturedDialplanResult[1].id, dialplanDTO[1].id)
        XCTAssertEqual(capturedDialplanResult.last!.id, dialplanDTO.last!.id)
        XCTAssertEqual(capturedDialplanResult.first!.audiofile, dialplanDTO.first!.audioFile)
        XCTAssertEqual(capturedDialplanResult[1].audiofile, dialplanDTO[1].audioFile)
        XCTAssertEqual(capturedDialplanResult.last!.audiofile, dialplanDTO.last!.audioFile)
        XCTAssertEqual(capturedDialplanResult.first!.titulo, dialplanDTO.first!.titulo)
        XCTAssertEqual(capturedDialplanResult[1].titulo, dialplanDTO[1].titulo)
        XCTAssertEqual(capturedDialplanResult.last!.titulo, dialplanDTO.last!.titulo)
    }

    func test_getDialplan_returns_failure_when_dialplanDataSource_fails() async throws {
        // GIVEN
        let result: Result<[JokeDialplanDTO], HTTPClientError> = .failure(.generic)
        let apiDialplanStub = APIDialplanDataSourceStub(result: result)
        let sut = DialplanRepository(apiDataSource: apiDialplanStub,
                                     errorMapper: JokesPhoneDomainErrorMapper(),
                                     dialplanMapper: DialplanMapper())

        // WHEN
        let capturedResult = await sut.getDialplan()

        // THEN
        guard case .failure(let error) = capturedResult else {
            XCTFail("Expected failure, got success")
            return
        }

        XCTAssertEqual(error, JokesPhoneDomainError.generic)
    }
}

extension JokeDialplanDTO {
    static func makeDialplan() -> [JokeDialplanDTO] {
        var result: [JokeDialplanDTO] = []
        result.append(
            JokeDialplanDTO(
                id: "1",
                audioFile: "audioFile1",
                titulo: "titulo1",
                image: "image1",
                desc: "desc1",
                example: "example1",
                enabled: true
            )
        )
        result.append(
            JokeDialplanDTO(
                id: "2",
                audioFile: "audioFile2",
                titulo: "titulo2",
                image: "image2",
                desc: "desc2",
                example: "example2",
                enabled: false
            )
        )
        result.append(
            JokeDialplanDTO(
                id: "3",
                audioFile: "audioFile3",
                titulo: "titulo3",
                image: "image3",
                desc: "desc3",
                example: "example3",
                enabled: true
            )
        )
        return result
    }
}
