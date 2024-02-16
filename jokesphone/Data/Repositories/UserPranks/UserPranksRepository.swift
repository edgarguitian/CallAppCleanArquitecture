//
//  UserPranksRepository.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 9/2/24.
//

import Foundation

class UserPranksRepository: UserPranksRepositoryType {
    private let apiDataSource: APIUserPranksDataSourceType
    private let errorMapper: JokesPhoneDomainErrorMapper
    private let userPranksResultMapper: UserPranksResultMapper

    init(apiDataSource: APIUserPranksDataSourceType,
         errorMapper: JokesPhoneDomainErrorMapper,
         userPranksResultMapper: UserPranksResultMapper) {
        self.apiDataSource = apiDataSource
        self.errorMapper = errorMapper
        self.userPranksResultMapper = userPranksResultMapper
    }

    func getUserPranks() async -> Result<[UserPrank], JokesPhoneDomainError> {
        let userPranksResult = await apiDataSource.getUserPranks()

        guard case .success(let userPranks) = userPranksResult else {
            return .failure(errorMapper.map(error: userPranksResult.failureValue as? HTTPClientError))
        }

        let userPranksResultDomain = userPranksResultMapper.map(result: userPranks)

        return .success(userPranksResultDomain)

    }
}
