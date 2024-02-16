//
//  APIUserCreditDataSourceTests.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 14/2/24.
//

import XCTest
@testable import jokesphone
final class APIUserCreditDataSourceTests: XCTestCase {
    var dataSource: APIUserCreditDataSource!

    override func setUp() {
        super.setUp()
        let httpClient = URLSessionHTTPCLient(requestMaker: URLSessionRequestMaker(),
                                        errorResolver: URLSessionErrorResolver())
        dataSource = APIUserCreditDataSource(httpClient: httpClient)
    }

    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }

    func test_getUserCredit() async {
        let expectation = XCTestExpectation(description: "Credit")
        let result = await dataSource.getUserCredit()
        switch result {
        case .success(let userCreditDTO):
            XCTAssertNotNil(userCreditDTO)
        case .failure(let error):
            XCTFail("Status failed with error: \(error)")
        }
        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 5.0)

    }
}
