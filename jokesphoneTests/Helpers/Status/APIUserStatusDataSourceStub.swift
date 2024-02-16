//
//  APIUserStatusDataSourceStub.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 14/2/24.
//

import Foundation
@testable import jokesphone

final class APIUserStatusDataSourceStub: APIUserStatusDataSourceType {
    private let result: Result<UserStatusDTO, HTTPClientError>

    init(result: Result<UserStatusDTO, HTTPClientError>) {
        self.result = result
    }

    func getUserStatus() async -> Result<UserStatusDTO, HTTPClientError> {
        result
    }
}
