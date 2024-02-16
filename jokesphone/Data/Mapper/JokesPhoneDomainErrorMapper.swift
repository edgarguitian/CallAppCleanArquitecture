//
//  JokesPhoneDomainErrorMapper.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 7/2/24.
//

import Foundation

class JokesPhoneDomainErrorMapper {
    func map(error: HTTPClientError?) -> JokesPhoneDomainError {
        return .generic
    }
}
