//
//  GetDialplanStub.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 16/2/24.
//

import Foundation
@testable import jokesphone

class GetDialplanStub: GetDialplanType {

    private let isSuccess: Bool

    init(isSuccess: Bool) {
        self.isSuccess = isSuccess
    }

    func execute() async -> Result<[JokeDialplan], JokesPhoneDomainError> {
        if isSuccess {
            return .success(JokeDialplan.makeDialplan())
        } else {
            return .failure(JokesPhoneDomainError.generic)
        }
    }
}
