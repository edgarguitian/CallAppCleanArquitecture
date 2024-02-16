//
//  UserCreditRepository.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import Foundation

class UserCreditRepository: UserCreditRepositoryType {
    private let apiDataSource: APIUserCreditDataSourceType
    private let errorMapper: JokesPhoneDomainErrorMapper
    private let userCreditResultMapper: UserCreditResultMapper

    init(apiDataSource: APIUserCreditDataSourceType,
         errorMapper: JokesPhoneDomainErrorMapper,
         userCreditResultMapper: UserCreditResultMapper) {
        self.apiDataSource = apiDataSource
        self.errorMapper = errorMapper
        self.userCreditResultMapper = userCreditResultMapper
    }

    func getUserCredit() async -> Result<UserCredit, JokesPhoneDomainError> {
        let userCreditResult = await apiDataSource.getUserCredit()

        guard case .success(let userCredit) = userCreditResult else {
            return .failure(errorMapper.map(error: userCreditResult.failureValue as? HTTPClientError))
        }

        let userCreditResultDomain = userCreditResultMapper.map(result: userCredit)

        return .success(userCreditResultDomain)
    }

}
