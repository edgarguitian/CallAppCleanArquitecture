//
//  UserCreditRepositoryStub.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 15/2/24.
//

import Foundation
@testable import jokesphone

class UserCreditRepositoryStub: UserCreditRepositoryType {
    private let result: Result<UserCredit, JokesPhoneDomainError>

    init(result: Result<UserCredit, JokesPhoneDomainError>) {
        self.result = result
    }

    func getUserCredit() async -> Result<UserCredit, JokesPhoneDomainError> {
        result
    }
}
