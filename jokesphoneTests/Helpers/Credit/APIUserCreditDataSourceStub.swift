//
//  APIUserCreditDataSourceStub.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 15/2/24.
//

import Foundation
@testable import jokesphone

class APIUserCreditDataSourceStub: APIUserCreditDataSourceType {
    private let result: Result<UserCreditDTO, HTTPClientError>

    init(result: Result<UserCreditDTO, HTTPClientError>) {
        self.result = result
    }

    func getUserCredit() async -> Result<UserCreditDTO, HTTPClientError> {
        result
    }
}
