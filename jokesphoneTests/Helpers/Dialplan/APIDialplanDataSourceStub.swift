//
//  APIDialplanDataSourceStub.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 15/2/24.
//

import Foundation
@testable import jokesphone

class APIDialplanDataSourceStub: APIDialplanDataSourceType {
    private let result: Result<[JokeDialplanDTO], HTTPClientError>

    init(result: Result<[JokeDialplanDTO], HTTPClientError>) {
        self.result = result
    }

    func getDialplan() async -> Result<[JokeDialplanDTO], HTTPClientError> {
        result
    }
}
