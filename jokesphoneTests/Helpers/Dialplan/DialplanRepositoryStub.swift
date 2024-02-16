//
//  DialplanRepositoryStub.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 14/2/24.
//

import Foundation
@testable import jokesphone

class DialplanRepositoryStub: DialplanRepositoryType {
    private let result: Result<[JokeDialplan], JokesPhoneDomainError>

    init(result: Result<[JokeDialplan], JokesPhoneDomainError>) {
        self.result = result
    }

    func getDialplan() async -> Result<[JokeDialplan], JokesPhoneDomainError> {
        result
    }
}
