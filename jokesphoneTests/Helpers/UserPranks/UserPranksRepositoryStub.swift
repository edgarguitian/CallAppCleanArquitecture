//
//  UserPranksRepositoryStub.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 15/2/24.
//

import Foundation
@testable import jokesphone

class UserPranksRepositoryStub: UserPranksRepositoryType {
    private let result: Result<[UserPrank], JokesPhoneDomainError>

    init(result: Result<[UserPrank], JokesPhoneDomainError>) {
        self.result = result
    }

    func getUserPranks() async -> Result<[UserPrank], JokesPhoneDomainError> {
        result
    }
}
