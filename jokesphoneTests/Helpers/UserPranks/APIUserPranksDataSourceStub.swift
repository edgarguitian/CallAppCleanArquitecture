//
//  APIUserPranksDataSourceStub.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 15/2/24.
//

import Foundation
@testable import jokesphone

class APIUserPranksDataSourceStub: APIUserPranksDataSourceType {
    private let result: Result<[UserPrankDTO], HTTPClientError>

    init(result: Result<[UserPrankDTO], HTTPClientError>) {
        self.result = result
    }

    func getUserPranks() async -> Result<[UserPrankDTO], HTTPClientError> {
        result
    }
}
