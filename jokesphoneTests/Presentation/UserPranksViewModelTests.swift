//
//  UserPranksViewModelTests.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 16/2/24.
//

import XCTest
@testable import jokesphone
import Combine

final class UserPranksViewModelTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        cancellables.removeAll()
    }

    func test_init() {
        // GIVEN
        let userPranksStub =  GetUserPranksStub(isSuccess: true)
        let errorMapperStub = JokesPhonePresentableErrorMapperStub()
        let presentableMapper = UserPrankPresentableMapper()

        // WHEN
        let viewModel = UserPranksViewModel(getUserPranks: userPranksStub,
                                            errorMapper: errorMapperStub,
                                            presentableMapper: presentableMapper)

        // THEN
        XCTAssertTrue(viewModel.showLoadingSpinner)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.showError)
        XCTAssertEqual(viewModel.userPranks.count, 0)
    }

    func test_onAppear_sucess() {
        // GIVEN
        let userPranksStub =  GetUserPranksStub(isSuccess: true)
        let errorMapperStub = JokesPhonePresentableErrorMapperStub()
        let presentableMapper = UserPrankPresentableMapper()
        let viewModel = UserPranksViewModel(getUserPranks: userPranksStub,
                                            errorMapper: errorMapperStub,
                                            presentableMapper: presentableMapper)

        // WHEN
        let expectation = XCTestExpectation(description: "should return user pranks")
        viewModel.$userPranks
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
        XCTAssertEqual(viewModel.userPranks, presentableMapper.map(items: UserPrank.makeUserPranks()))
    }

    func test_onAppear_fail() throws {
        // GIVEN
        let userPranksStub =  GetUserPranksStub(isSuccess: false)
        let errorMapperStub = JokesPhonePresentableErrorMapperStub()
        let presentableMapper = UserPrankPresentableMapper()
        let viewModel = UserPranksViewModel(getUserPranks: userPranksStub,
                                            errorMapper: errorMapperStub,
                                            presentableMapper: presentableMapper)

        // WHEN
        let expectation = XCTestExpectation(description: "should return error message")
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
        XCTAssertEqual(viewModel.userPranks.count, 0)
    }

}
