//
//  JokesPhonePresentableErrorMapperStub.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 16/2/24.
//

import Foundation
@testable import jokesphone

class JokesPhonePresentableErrorMapperStub: JokesPhonePresentableErrorMapper {
    override func map(error: JokesPhoneDomainError?) -> String {
        return "Stub Error Message"
    }
}
