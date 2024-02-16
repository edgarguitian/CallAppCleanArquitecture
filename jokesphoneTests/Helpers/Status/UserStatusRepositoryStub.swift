//
//  UserStatusRepositoryStub.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 14/2/24.
//

import Foundation
@testable import jokesphone

class UserStatusRepositoryStub: UserStatusRepositoryType {
    private let result: Result<UserStatus, JokesPhoneDomainError>

    init(result: Result<UserStatus, JokesPhoneDomainError>) {
        self.result = result
    }

    func getUserStatus() async -> Result<UserStatus, JokesPhoneDomainError> {
        return result
    }
}
