//
//  SplashViewModelTests.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 15/2/24.
//

import XCTest
@testable import jokesphone
import Combine
class SplashViewModelTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        cancellables.removeAll()
    }

    func test_init() {
        // GIVEN
        let userStatusStub =  GetStatusStub(isSuccess: true)
        let errorMapperStub = JokesPhonePresentableErrorMapperStub()

        // WHEN
        let viewModel = SplashViewModel(getUserStatus: userStatusStub,
                                        errorMapper: errorMapperStub)

        // THEN
        XCTAssertTrue(viewModel.showLoadingSpinner)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.showError)
    }

    func test_onAppear_sucess() {
        // GIVEN
        let viewModel = SplashViewModel(getUserStatus: GetStatusStub(isSuccess: true),
                                        errorMapper: JokesPhonePresentableErrorMapperStub())

        // WHEN
        let expectation = XCTestExpectation(description: "should return status")
        viewModel.$currentStatus
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.onAppear()

        // THEN
        wait(for: [expectation], timeout: 5)
        XCTAssertFalse(viewModel.showLoadingSpinner)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.showError)
        XCTAssertEqual(viewModel.currentStatus, UserStatus.makeUserStatus())
    }

    func test_onAppear_fail() throws {
        // GIVEN
        let viewModel = SplashViewModel(getUserStatus: GetStatusStub(isSuccess: false),
                                        errorMapper: JokesPhonePresentableErrorMapperStub())

        // WHEN
        let expectation = XCTestExpectation(description: "should return error")
        viewModel.$errorMessage
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.onAppear()

        // THEN
        wait(for: [expectation], timeout: 5)
        XCTAssertFalse(viewModel.showLoadingSpinner)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.showError)
        XCTAssertNil(viewModel.currentStatus)
    }

}
