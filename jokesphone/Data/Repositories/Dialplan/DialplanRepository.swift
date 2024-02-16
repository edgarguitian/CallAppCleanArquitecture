//
//  DialplanRepository.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 7/2/24.
//

import Foundation

class DialplanRepository: DialplanRepositoryType {
    private let apiDataSource: APIDialplanDataSourceType
    private let errorMapper: JokesPhoneDomainErrorMapper
    private let dialplanMapper: DialplanMapper

    init(apiDataSource: APIDialplanDataSourceType,
         errorMapper: JokesPhoneDomainErrorMapper,
         dialplanMapper: DialplanMapper) {
        self.apiDataSource = apiDataSource
        self.errorMapper = errorMapper
        self.dialplanMapper = dialplanMapper
    }

    func getDialplan() async -> Result<[JokeDialplan], JokesPhoneDomainError> {
        let dialplan = await apiDataSource.getDialplan()

        guard case .success(let dialplanInfo) = dialplan else {
            return .failure(errorMapper.map(error: dialplan.failureValue as? HTTPClientError))
        }

        let dialplanDomain = dialplanMapper.map(items: dialplanInfo)

        return .success(dialplanDomain)

    }
}
