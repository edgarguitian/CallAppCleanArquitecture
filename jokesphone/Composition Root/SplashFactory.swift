//
//  SplashFactory.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import Foundation

class SplashFactory {
    static func create() -> SplashView {
        return SplashView(viewModel: createSplashViewModel(),
                          createMainView: MainViewFactory())
    }

    private static func createSplashViewModel() -> SplashViewModel {
        return SplashViewModel(getUserStatus: createGetStatusUseCase(),
                               errorMapper: JokesPhonePresentableErrorMapper())
    }

    private static func createGetStatusUseCase() -> GetStatusType {
        return GetStatus(repository: createUserStatusRepository())
    }

    private static func createUserStatusRepository() -> UserStatusRepositoryType {
        return UserStatusRepository(apiDataSource: createApiUserStatusDataSource(),
                                    errorMapper: JokesPhoneDomainErrorMapper(),
                                    userStatusResultMapper: UserStatusResultMapper())
    }

    private static func createApiUserStatusDataSource() -> APIUserStatusDataSourceType {
        return APIUserStatusDataSource(httpClient: createHTTPClient())
    }

    private static func createHTTPClient() -> HTTPClient {
        return URLSessionHTTPCLient(requestMaker: URLSessionRequestMaker(),
                                    errorResolver: URLSessionErrorResolver())
    }

}
