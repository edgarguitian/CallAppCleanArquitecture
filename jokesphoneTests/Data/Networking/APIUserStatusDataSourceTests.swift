//
//  APIUserStatusDataSourceTests.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 14/2/24.
//

import XCTest
@testable import jokesphone
final class APIUserStatusDataSourceTests: XCTestCase {

    var dataSource: APIUserStatusDataSource!

    override func setUp() {
        super.setUp()
        let httpClient = URLSessionHTTPCLient(requestMaker: URLSessionRequestMaker(),
                                        errorResolver: URLSessionErrorResolver())
        dataSource = APIUserStatusDataSource(httpClient: httpClient)
    }

    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }

    func test_getUserStatus() async {
        let expectation = XCTestExpectation(description: "Status")
        let result = await dataSource.getUserStatus()
        switch result {
        case .success(let userStatusDTO):
            XCTAssertNotNil(userStatusDTO)
        case .failure(let error):
            XCTFail("Status failed with error: \(error)")
        }
        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 5.0)

    }

}
