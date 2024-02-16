//
//  MockGetStatusType.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 16/2/24.
//

import Foundation
@testable import jokesphone

class GetStatusStub: GetStatusType {
    private let isSuccess: Bool

    init(isSuccess: Bool) {
        self.isSuccess = isSuccess
    }

    func execute() async -> Result<UserStatus, JokesPhoneDomainError> {
        if isSuccess {
            return .success(UserStatus.makeUserStatus())
        } else {
            return .failure(JokesPhoneDomainError.generic)
        }
    }
}
