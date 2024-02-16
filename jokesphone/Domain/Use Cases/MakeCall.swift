//
//  MakeCall.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 8/2/24.
//

import Foundation

class MakeCall: MakeCallType {
    private let repository: MakeCallRepositoryType

    init(repository: MakeCallRepositoryType) {
        self.repository = repository
    }

    func execute(title: String,
                 dial: String,
                 dstCall: String,
                 name: String) async -> Result<MakeCallResult, JokesPhoneDomainError> {
        let result = await repository.makeCall(title: title,
                                               dial: dial,
                                               dstCall: dstCall,
                                               name: name)

        guard let callResult = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }

            return .failure(error)
        }

        return .success(callResult)
    }
}
