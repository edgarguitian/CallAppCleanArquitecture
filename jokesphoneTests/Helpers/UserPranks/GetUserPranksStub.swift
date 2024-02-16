//
//  GetUserPranksStub.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 16/2/24.
//

import Foundation
@testable import jokesphone

class GetUserPranksStub: GetUserPranksType {
    private let isSuccess: Bool

    init(isSuccess: Bool) {
        self.isSuccess = isSuccess
    }

    func execute() async -> Result<[UserPrank], JokesPhoneDomainError> {
        if isSuccess {
            return .success(UserPrank.makeUserPranks())
        } else {
            return .failure(.generic)
        }
    }
}
