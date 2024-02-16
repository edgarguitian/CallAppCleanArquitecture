//
//  GetDialplan.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 7/2/24.
//

import Foundation

class GetDialplan: GetDialplanType {
    private let repository: DialplanRepositoryType

    init(repository: DialplanRepositoryType) {
        self.repository = repository
    }

    func execute() async -> Result<[JokeDialplan], JokesPhoneDomainError> {
        let result = await repository.getDialplan()

        guard let dialplan = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }

            return .failure(error)
        }

        return .success(dialplan)
    }
}
