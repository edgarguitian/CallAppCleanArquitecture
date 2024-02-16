//
//  GetStatus.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import Foundation

class GetStatus: GetStatusType {
    private let repository: UserStatusRepositoryType

    init(repository: UserStatusRepositoryType) {
        self.repository = repository
    }

    func execute() async -> Result<UserStatus, JokesPhoneDomainError> {
        let result = await repository.getUserStatus()

        guard let userStatus = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }

            return .failure(error)
        }

        return .success(userStatus)
    }
}
