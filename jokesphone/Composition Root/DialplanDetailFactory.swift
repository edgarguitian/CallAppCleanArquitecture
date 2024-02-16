//
//  DialplanDetailFactory.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 8/2/24.
//

import Foundation

class DialplanDetailFactory: CreateDialplanDetailView {
    func create(jokeDialplan: JokeDialplanPresentableItem) -> DialplanDetailView {
        return DialplanDetailView(viewModel: createDialplanDetailViewModel(jokeDialplan: jokeDialplan),
                                  createBottomCredit: BottomCreditFactory())
    }

    private func createDialplanDetailViewModel(jokeDialplan: JokeDialplanPresentableItem) -> DialplanDetailViewModel {
        return DialplanDetailViewModel(jokeDialplan: jokeDialplan,
                                       makeCallUseCase: createMakeCallUseCase())
    }

    private func createMakeCallUseCase() -> MakeCallType {
        return MakeCall(repository: createMakeCallRepository())
    }

    private func createMakeCallRepository() -> MakeCallRepositoryType {
        return MakeCallRepository(apiDataSource: createAPIMakeCallDataSource(),
                                  errorMapper: JokesPhoneDomainErrorMapper(),
                                  callResultMapper: CallResultMapper())
    }

    private func createAPIMakeCallDataSource() -> APIMakeCallDataSourceType {
        return APIMakeCallDataSource(httpClient: DialplanDetailFactory.createHTTPClient())
    }

    private static func createHTTPClient() -> HTTPClient {
        return URLSessionHTTPCLient(requestMaker: URLSessionRequestMaker(),
                                    errorResolver: URLSessionErrorResolver())
    }
}
