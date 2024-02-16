//
//  BottomCreditFactory.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import Foundation

class BottomCreditFactory: CreateBottomView {
    func create() -> BottomCreditView {
        return BottomCreditView(viewModel: createBottomCreditViewModel(),
                                createShop: ShopFactory())
    }

    private func createBottomCreditViewModel() -> BottomCreditViewModel {
        return BottomCreditViewModel(getCredit: createGetCreditUseCase())
    }

    private func createGetCreditUseCase() -> GetCreditType {
        return GetCredit(repository: createUserCreditRepository())
    }

    private func createUserCreditRepository() -> UserCreditRepositoryType {
        return UserCreditRepository(apiDataSource: createApiUserCreditDataSource(),
                                    errorMapper: JokesPhoneDomainErrorMapper(),
                                    userCreditResultMapper: UserCreditResultMapper())
    }

    private func createApiUserCreditDataSource() -> APIUserCreditDataSourceType {
        return APIUserCreditDataSource(httpClient: createHTTPClient())
    }

    private func createHTTPClient() -> HTTPClient {
        return URLSessionHTTPCLient(requestMaker: URLSessionRequestMaker(),
                                    errorResolver: URLSessionErrorResolver())
    }
}
