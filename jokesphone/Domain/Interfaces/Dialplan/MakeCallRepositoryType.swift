//
//  MakeCallRepositoryType.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 8/2/24.
//

import Foundation

protocol MakeCallRepositoryType {
    func makeCall(title: String,
                  dial: String,
                  dstCall: String,
                  name: String) async -> Result<MakeCallResult, JokesPhoneDomainError>
}
