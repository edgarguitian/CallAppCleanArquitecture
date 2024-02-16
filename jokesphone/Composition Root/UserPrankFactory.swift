//
//  UserPrankFactory.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 9/2/24.
//

import Foundation

class UserPrankFactory {
    static func create() -> UserPranksView {
        return UserPranksView(viewModel: createUserPranksViewModel(),
                              createConfig: ConfigFactory(),
                              createBottomCredit: BottomCreditFactory())
    }

    private static func createUserPranksViewModel() -> UserPranksViewModel {
        return UserPranksViewModel(getUserPranks: createGetUserPranksUseCase(),
                                   errorMapper: JokesPhonePresentableErrorMapper(),
                                   presentableMapper: UserPrankPresentableMapper())
    }

    private static func createGetUserPranksUseCase() -> GetUserPranksType {
        return GetUserPranks(repository: createUserPranksRepository())
    }

    private static func createUserPranksRepository() -> UserPranksRepositoryType {
        return UserPranksRepository(apiDataSource: createApiUserPranksDataSource(),
                                    errorMapper: JokesPhoneDomainErrorMapper(),
                                    userPranksResultMapper: UserPranksResultMapper())
    }

    private static func createApiUserPranksDataSource() -> APIUserPranksDataSourceType {
        return APIUserPranksDataSource(httpClient: createHTTPClient())
    }

    private static func createHTTPClient() -> HTTPClient {
        return URLSessionHTTPCLient(requestMaker: URLSessionRequestMaker(),
                                    errorResolver: URLSessionErrorResolver())
    }
}
