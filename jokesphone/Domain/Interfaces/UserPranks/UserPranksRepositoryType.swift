//
//  UserPranksRepositoryType.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 9/2/24.
//

import Foundation

protocol UserPranksRepositoryType {
    func getUserPranks() async -> Result<[UserPrank], JokesPhoneDomainError>
}
