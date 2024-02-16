//
//  BottomCreditViewModelTests.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 16/2/24.
//

import XCTest
@testable import jokesphone
import Combine

final class BottomCreditViewModelTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        cancellables.removeAll()
    }

    func test_init() {
        // GIVEN
        let getCreditStub =  GetCreditStub(isSuccess: true)

        // WHEN
        let viewModel = BottomCreditViewModel(getCredit: getCreditStub)

        // THEN
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel.userCredit, 0)
    }

    func test_onAppear_sucess() {
        // GIVEN
        let getCreditStub =  GetCreditStub(isSuccess: true)
        let viewModel = BottomCreditViewModel(getCredit: getCreditStub)

        // WHEN
        let expectation = XCTestExpectation(description: "should return credit")
        viewModel.$userCredit
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.onAppear()

        // THEN
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(viewModel.userCredit, UserCredit.makeUserCredit().credit)
    }

    func test_onAppear_fail() throws {
        // GIVEN
        let getCreditStub =  GetCreditStub(isSuccess: false)
        let viewModel = BottomCreditViewModel(getCredit: getCreditStub)

        // WHEN
        let expectation = XCTestExpectation(description: "should return error")
        viewModel.$showError
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.onAppear()

        // THEN
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(viewModel.showError)

    }

}
