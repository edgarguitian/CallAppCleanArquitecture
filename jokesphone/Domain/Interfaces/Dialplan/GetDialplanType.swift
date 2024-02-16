//
//  GetDialplanType.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 7/2/24.
//

import Foundation

protocol GetDialplanType {
    func execute() async -> Result<[JokeDialplan], JokesPhoneDomainError>
}
