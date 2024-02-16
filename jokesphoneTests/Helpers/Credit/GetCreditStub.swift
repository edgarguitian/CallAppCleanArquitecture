//
//  GetCreditStub.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 16/2/24.
//

import Foundation
@testable import jokesphone

class GetCreditStub: GetCreditType {
    private let isSuccess: Bool

    init(isSuccess: Bool) {
        self.isSuccess = isSuccess
    }

    func execute() async -> Result<UserCredit, JokesPhoneDomainError> {
        if isSuccess {
            return .success(UserCredit.makeUserCredit())
        } else {
            return .failure(JokesPhoneDomainError.generic)
        }
    }
}
