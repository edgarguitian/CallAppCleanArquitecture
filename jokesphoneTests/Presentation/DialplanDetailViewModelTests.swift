//
//  DialplanDetailViewModelTests.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 16/2/24.
//

import XCTest
@testable import jokesphone
import Combine
final class DialplanDetailViewModelTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        cancellables.removeAll()
    }

    func test_init() {
        // GIVEN
        let makeCallStub =  MakeCallStub(isSuccess: true)

        // WHEN
        let viewModel = DialplanDetailViewModel(jokeDialplan: JokeDialplanPresentableItem.makePreview(),
                                                makeCallUseCase: makeCallStub)

        // THEN
        XCTAssertTrue(viewModel.showLoadingSpinner)
        XCTAssertTrue(viewModel.contactNumber.isEmpty)
        XCTAssertFalse(viewModel.showAlertResult)
        XCTAssertFalse(viewModel.alertResultError)
        XCTAssertTrue(viewModel.resultMessage.isEmpty)
    }

    func test_makeCall_sucess() {
        // GIVEN
        let makeCallStub =  MakeCallStub(isSuccess: true)
        let viewModel = DialplanDetailViewModel(jokeDialplan: JokeDialplanPresentableItem.makePreview(),
                                                makeCallUseCase: makeCallStub)
        // WHEN
        let expectation = XCTestExpectation(description: "should return call result")
        viewModel.$alertResultError
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.makeCall()

        // THEN
        wait(for: [expectation], timeout: 5)
        XCTAssertFalse(viewModel.showLoadingSpinner)
        XCTAssertTrue(viewModel.showAlertResult)
        XCTAssertFalse(viewModel.resultMessage.isEmpty)
        XCTAssertFalse(viewModel.alertResultError)

    }

    func test_makeCall_fail() throws {
        // GIVEN
        let makeCallStub =  MakeCallStub(isSuccess: false)
        let viewModel = DialplanDetailViewModel(jokeDialplan: JokeDialplanPresentableItem.makePreview(),
                                                makeCallUseCase: makeCallStub)
        // WHEN
        let expectation = XCTestExpectation(description: "should return alert")
        viewModel.$alertResultError
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.makeCall()

        // THEN
        wait(for: [expectation], timeout: 5)
        XCTAssertFalse(viewModel.showLoadingSpinner)
        XCTAssertTrue(viewModel.showAlertResult)
        XCTAssertFalse(viewModel.resultMessage.isEmpty)
        XCTAssertTrue(viewModel.alertResultError)

    }

}
