//
//  GetStatusType.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import Foundation

protocol GetStatusType {
    func execute() async -> Result<UserStatus, JokesPhoneDomainError>
}
