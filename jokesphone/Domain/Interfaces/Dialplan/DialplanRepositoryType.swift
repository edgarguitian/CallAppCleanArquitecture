//
//  DialplanRepositoryType.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 7/2/24.
//

import Foundation

protocol DialplanRepositoryType {
    func getDialplan() async -> Result<[JokeDialplan], JokesPhoneDomainError>
}
