//
//  GetUserPranksType.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 9/2/24.
//

import Foundation

protocol GetUserPranksType {
    func execute() async -> Result<[UserPrank], JokesPhoneDomainError>
}
