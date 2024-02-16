//
//  GetCreditType.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import Foundation

protocol GetCreditType {
    func execute() async -> Result<UserCredit, JokesPhoneDomainError>
}
