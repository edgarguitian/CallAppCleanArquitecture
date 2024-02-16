//
//  GetCredit.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import Foundation

class GetCredit: GetCreditType {
    private let repository: UserCreditRepositoryType

    init(repository: UserCreditRepositoryType) {
        self.repository = repository
    }

    func execute() async -> Result<UserCredit, JokesPhoneDomainError> {
        let result = await repository.getUserCredit()

        guard let userCredit = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }

            return .failure(error)
        }

        return .success(userCredit)
    }
}
