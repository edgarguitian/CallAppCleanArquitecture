//
//  UserStatusRepository.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import Foundation

class UserStatusRepository: UserStatusRepositoryType {
    private let apiDataSource: APIUserStatusDataSourceType
    private let errorMapper: JokesPhoneDomainErrorMapper
    private let userStatusResultMapper: UserStatusResultMapper

    init(apiDataSource: APIUserStatusDataSourceType,
         errorMapper: JokesPhoneDomainErrorMapper,
         userStatusResultMapper: UserStatusResultMapper) {
        self.apiDataSource = apiDataSource
        self.errorMapper = errorMapper
        self.userStatusResultMapper = userStatusResultMapper
    }

    func getUserStatus() async -> Result<UserStatus, JokesPhoneDomainError> {
        let userStatusResult = await apiDataSource.getUserStatus()

        guard case .success(let userStatus) = userStatusResult else {
            return .failure(errorMapper.map(error: userStatusResult.failureValue as? HTTPClientError))
        }

        let userStatusResultDomain = userStatusResultMapper.map(result: userStatus)

        return .success(userStatusResultDomain)

    }
}
