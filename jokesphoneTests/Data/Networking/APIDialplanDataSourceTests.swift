//
//  APIDialplanDataSourceTests.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 14/2/24.
//

import XCTest
@testable import jokesphone
final class APIDialplanDataSourceTests: XCTestCase {
    var dataSource: APIDialplanDataSource!

    override func setUp() {
        super.setUp()
        let httpClient = URLSessionHTTPCLient(requestMaker: URLSessionRequestMaker(),
                                        errorResolver: URLSessionErrorResolver())
        dataSource = APIDialplanDataSource(httpClient: httpClient)
    }

    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }

    func test_getDialplan() async {
        let expectation = XCTestExpectation(description: "Dialplan")
        let result = await dataSource.getDialplan()
        switch result {
        case .success(let dialplanDTO):
            XCTAssertNotNil(dialplanDTO)
        case .failure(let error):
            XCTFail("Status failed with error: \(error)")
        }
        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 5.0)

    }
}
