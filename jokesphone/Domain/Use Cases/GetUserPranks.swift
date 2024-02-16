//
//  GetUserPranks.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 8/2/24.
//

import Foundation

class GetUserPranks: GetUserPranksType {
    private let repository: UserPranksRepositoryType

    init(repository: UserPranksRepositoryType) {
        self.repository = repository
    }

    func execute() async -> Result<[UserPrank], JokesPhoneDomainError> {
        let result = await repository.getUserPranks()

        guard let userPranks = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }

            return .failure(error)
        }

        return .success(userPranks)
    }
}
