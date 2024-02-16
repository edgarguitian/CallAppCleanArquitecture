//
//  APIMakeCallDataSourceTests.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 15/2/24.
//

import XCTest
@testable import jokesphone
final class APIMakeCallDataSourceTests: XCTestCase {

    var dataSource: APIMakeCallDataSource!

    override func setUp() {
        super.setUp()
        let httpClient = URLSessionHTTPCLient(requestMaker: URLSessionRequestMaker(),
                                        errorResolver: URLSessionErrorResolver())
        dataSource = APIMakeCallDataSource(httpClient: httpClient)
    }

    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }

    func test_makeCall() async {
        let expectation = XCTestExpectation(description: "Call")
        let result = await dataSource.makeCall(title: "title1", dial: "dial1", dstCall: "dstCall1", name: "name1")
        switch result {
        case .success(let makeCallDTO):
            XCTAssertNotNil(makeCallDTO)
        case .failure(let error):
            XCTFail("Status failed with error: \(error)")
        }
        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 5.0)

    }

}
