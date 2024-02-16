//
//  UserStatusRepositoryType.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import Foundation

protocol UserStatusRepositoryType {
    func getUserStatus() async -> Result<UserStatus, JokesPhoneDomainError>
}
