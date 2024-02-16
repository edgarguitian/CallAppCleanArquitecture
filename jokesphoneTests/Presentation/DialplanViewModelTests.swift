//
//  DialplanViewModelTests.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 16/2/24.
//

import XCTest
@testable import jokesphone
import Combine

final class DialplanViewModelTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        cancellables.removeAll()
    }

    func test_init() {
        // GIVEN
        let getDialplanStub =  GetDialplanStub(isSuccess: true)
        let errorMapperStub = JokesPhonePresentableErrorMapperStub()

        // WHEN
        let viewModel = DialplanViewModel(getDialplan: getDialplanStub,
                                          errorMapper: errorMapperStub,
                                          presentableMapper: JokeDialplanPresentableMapper())

        // THEN
        XCTAssertTrue(viewModel.showLoadingSpinner)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.showError)
        XCTAssertEqual(viewModel.filteredJokeDialplan.count, 0)
    }

    func test_onAppear_sucess() {
        // GIVEN
        let getDialplanStub =  GetDialplanStub(isSuccess: true)
        let presentableMapper = JokeDialplanPresentableMapper()
        let errorMapperStub = JokesPhonePresentableErrorMapperStub()
        let viewModel = DialplanViewModel(getDialplan: getDialplanStub,
                                          errorMapper: errorMapperStub,
                                          presentableMapper: presentableMapper)

        // WHEN
        let expectation = XCTestExpectation(description: "should return dialplan")
        viewModel.$filteredJokeDialplan
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
        XCTAssertEqual(viewModel.filteredJokeDialplan, presentableMapper.map(items: JokeDialplan.makeDialplan()))
    }

    func test_onAppear_fail() throws {
        // GIVEN
        let getDialplanStub =  GetDialplanStub(isSuccess: false)
        let presentableMapper = JokeDialplanPresentableMapper()
        let errorMapperStub = JokesPhonePresentableErrorMapperStub()
        let viewModel = DialplanViewModel(getDialplan: getDialplanStub,
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
        XCTAssertEqual(viewModel.filteredJokeDialplan.count, 0)
    }

    func test_search_empty() throws {
        // GIVEN
        let getDialplanStub =  GetDialplanStub(isSuccess: true)
        let presentableMapper = JokeDialplanPresentableMapper()
        let errorMapperStub = JokesPhonePresentableErrorMapperStub()
        let viewModel = DialplanViewModel(getDialplan: getDialplanStub,
                                          errorMapper: errorMapperStub,
                                          presentableMapper: presentableMapper)

        let expectation = XCTestExpectation(description: "should return dialplan")
        viewModel.$filteredJokeDialplan
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.onAppear()
        wait(for: [expectation], timeout: 5)

        // WHEN
        let expectationSearch = XCTestExpectation(description: "should return dialplan equal")
        viewModel.$filteredJokeDialplan
            .dropFirst()
            .sink { _ in
                expectationSearch.fulfill()
            }
            .store(in: &cancellables)
        viewModel.search(searchText: "")
        wait(for: [expectationSearch], timeout: 5)

        // THEN
        XCTAssertEqual(viewModel.filteredJokeDialplan, viewModel.jokeDialplan)
    }

    func test_search_notempty_returns_filtered_dialplan_by_title() throws {
        // GIVEN
        let getDialplanStub =  GetDialplanStub(isSuccess: true)
        let presentableMapper = JokeDialplanPresentableMapper()
        let errorMapperStub = JokesPhonePresentableErrorMapperStub()
        let viewModel = DialplanViewModel(getDialplan: getDialplanStub,
                                          errorMapper: errorMapperStub,
                                          presentableMapper: presentableMapper)

        let expectation = XCTestExpectation(description: "should return dialplan")
        viewModel.$filteredJokeDialplan
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.onAppear()
        wait(for: [expectation], timeout: 5)

        // WHEN
        let expectationSearch = XCTestExpectation(description: "should return dialplan filtered")
        viewModel.$filteredJokeDialplan
            .dropFirst()
            .sink { _ in
                expectationSearch.fulfill()
            }
            .store(in: &cancellables)
        viewModel.search(searchText: "titulo1")
        wait(for: [expectationSearch], timeout: 5)

        // THEN
        XCTAssertEqual(viewModel.filteredJokeDialplan.count, 1)
    }

    func test_search_notempty_returns_filtered_dialplan_by_desc() throws {
        // GIVEN
        let getDialplanStub =  GetDialplanStub(isSuccess: true)
        let presentableMapper = JokeDialplanPresentableMapper()
        let errorMapperStub = JokesPhonePresentableErrorMapperStub()
        let viewModel = DialplanViewModel(getDialplan: getDialplanStub,
                                          errorMapper: errorMapperStub,
                                          presentableMapper: presentableMapper)

        let expectation = XCTestExpectation(description: "should return dialplan")
        viewModel.$filteredJokeDialplan
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.onAppear()
        wait(for: [expectation], timeout: 5)

        // WHEN
        let expectationSearch = XCTestExpectation(description: "should return dialplan filtered")
        viewModel.$filteredJokeDialplan
            .dropFirst()
            .sink { _ in
                expectationSearch.fulfill()
            }
            .store(in: &cancellables)
        viewModel.search(searchText: "desc1")
        wait(for: [expectationSearch], timeout: 5)

        // THEN
        XCTAssertEqual(viewModel.filteredJokeDialplan.count, 1)
    }

    func test_search_one_char_not_search() throws {
        // GIVEN
        let getDialplanStub =  GetDialplanStub(isSuccess: true)
        let presentableMapper = JokeDialplanPresentableMapper()
        let errorMapperStub = JokesPhonePresentableErrorMapperStub()
        let viewModel = DialplanViewModel(getDialplan: getDialplanStub,
                                          errorMapper: errorMapperStub,
                                          presentableMapper: presentableMapper)

        let expectation = XCTestExpectation(description: "should return dialplan")
        viewModel.$filteredJokeDialplan
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.onAppear()
        wait(for: [expectation], timeout: 5)

        // WHEN
        let expectationSearch = XCTestExpectation(description: "should return dialplan equal")
        viewModel.$filteredJokeDialplan
            .dropFirst()
            .sink { _ in
                expectationSearch.fulfill()
            }
            .store(in: &cancellables)
        viewModel.search(searchText: "1")
        wait(for: [expectationSearch], timeout: 5)

        // THEN
        XCTAssertEqual(viewModel.filteredJokeDialplan, viewModel.jokeDialplan)
    }

}
