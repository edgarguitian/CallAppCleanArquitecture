//
//  DialplanFactory.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 7/2/24.
//

import Foundation

class DialplanFactory {
    static func create() -> DialplanView {
        return DialplanView(viewModel: createDialplanViewModel(),
                            createDialplanDetail: DialplanDetailFactory(),
                            createConfig: ConfigFactory(),
                            createBottomCredit: BottomCreditFactory())
    }

    private static func createDialplanViewModel() -> DialplanViewModel {
        return DialplanViewModel(getDialplan: createGetDialplanUseCase(),
                                 errorMapper: JokesPhonePresentableErrorMapper(),
                                 presentableMapper: JokeDialplanPresentableMapper())
    }

    private static func createGetDialplanUseCase() -> GetDialplanType {
        return GetDialplan(repository: createDialplanRepository())
    }

    private static func createDialplanRepository() -> DialplanRepositoryType {
        return DialplanRepository(apiDataSource: createApiDialplanDataSource(),
                                  errorMapper: JokesPhoneDomainErrorMapper(),
                                  dialplanMapper: DialplanMapper())
    }

    private static func createApiDialplanDataSource() -> APIDialplanDataSourceType {
        return APIDialplanDataSource(httpClient: createHTTPClient())
    }

    private static func createHTTPClient() -> HTTPClient {
        return URLSessionHTTPCLient(requestMaker: URLSessionRequestMaker(),
                                    errorResolver: URLSessionErrorResolver())
    }

}
