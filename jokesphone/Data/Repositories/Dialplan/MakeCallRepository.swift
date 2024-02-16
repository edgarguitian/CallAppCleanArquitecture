//
//  MakeCallRepository.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 8/2/24.
//

import Foundation

class MakeCallRepository: MakeCallRepositoryType {
    private let apiDataSource: APIMakeCallDataSourceType
    private let errorMapper: JokesPhoneDomainErrorMapper
    private let callResultMapper: CallResultMapper

    init(apiDataSource: APIMakeCallDataSourceType,
         errorMapper: JokesPhoneDomainErrorMapper,
         callResultMapper: CallResultMapper) {
        self.apiDataSource = apiDataSource
        self.errorMapper = errorMapper
        self.callResultMapper = callResultMapper
    }

    func makeCall(title: String,
                  dial: String,
                  dstCall: String,
                  name: String) async -> Result<MakeCallResult, JokesPhoneDomainError> {
        let callResult = await apiDataSource.makeCall(title: title,
                                                      dial: dial,
                                                      dstCall: dstCall,
                                                      name: name)

        guard case .success(let (callId, callInfo)) = callResult else {
            return .failure(errorMapper.map(error: callResult.failureValue as? HTTPClientError))
        }

        var makeCallResultDomain = callResultMapper.map(result: callInfo)
        makeCallResultDomain.idCall = callId
        return .success(makeCallResultDomain)

    }
}
