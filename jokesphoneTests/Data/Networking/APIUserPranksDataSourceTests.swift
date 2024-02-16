//
//  APIUserPranksDataSourceTests.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 15/2/24.
//

import XCTest
@testable import jokesphone
final class APIUserPranksDataSourceTests: XCTestCase {
    var dataSource: APIUserPranksDataSource!

    override func setUp() {
        super.setUp()
        let httpClient = URLSessionHTTPCLient(requestMaker: URLSessionRequestMaker(),
                                        errorResolver: URLSessionErrorResolver())
        dataSource = APIUserPranksDataSource(httpClient: httpClient)
    }

    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }

    func test_getUserPranks() async {
        let expectation = XCTestExpectation(description: "Pranks")
        let result = await dataSource.getUserPranks()
        switch result {
        case .success(let userPranksDTO):
            XCTAssertNotNil(userPranksDTO)
        case .failure(let error):
            XCTFail("Status failed with error: \(error)")
        }
        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 5.0)

    }
}
