//
//  UserCreditRepositoryType.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import Foundation

protocol UserCreditRepositoryType {
    func getUserCredit() async -> Result<UserCredit, JokesPhoneDomainError>
}
