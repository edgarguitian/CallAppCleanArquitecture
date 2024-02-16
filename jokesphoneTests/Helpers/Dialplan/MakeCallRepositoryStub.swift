//
//  MakeCallRepositoryStub.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 15/2/24.
//

import Foundation
@testable import jokesphone

class MakeCallRepositoryStub: MakeCallRepositoryType {
    private let result: Result<MakeCallResult, JokesPhoneDomainError>

    init(result: Result<MakeCallResult, JokesPhoneDomainError>) {
        self.result = result
    }

    func makeCall(title: String,
                  dial: String,
                  dstCall: String,
                  name: String) async -> Result<MakeCallResult, JokesPhoneDomainError> {
        result
    }
}
