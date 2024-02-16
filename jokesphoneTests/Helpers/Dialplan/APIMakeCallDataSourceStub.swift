//
//  APIMakeCallDataSourceStub.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 15/2/24.
//

import Foundation
@testable import jokesphone

class APIMakeCallDataSourceStub: APIMakeCallDataSourceType {
    private let result: Result<(String, MakeCallResultDTO), HTTPClientError>

    init(result: Result<(String, MakeCallResultDTO), HTTPClientError>) {
        self.result = result
    }

    func makeCall(title: String,
                  dial: String,
                  dstCall: String,
                  name: String) async -> Result<(String, MakeCallResultDTO), HTTPClientError> {
        result
    }
}
