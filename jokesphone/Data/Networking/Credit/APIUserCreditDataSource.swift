//
//  APIUserCreditDataSource.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import Foundation

class APIUserCreditDataSource: APIUserCreditDataSourceType {
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    func getUserCredit() async -> Result<UserCreditDTO, HTTPClientError> {
        let body: [String: Any] = [
            "did": ""
        ]

        let queryParameters: [String: Any] = [:]

        let endpoint = Endpoint(path: "",
                                queryParameters: queryParameters,
                                body: body,
                                method: .post)

        let result = await httpClient.makeRequest(endpoint: endpoint, baseUrl: "")

        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }

        guard let userCreditResponse = try? JSONDecoder().decode(UserCreditDTO.self, from: data) else {
            return .failure(.parsingError)
        }
        return .success(userCreditResponse)
    }

    private func handleError(error: HTTPClientError?) -> HTTPClientError {
        guard let error = error else {
            return .generic
        }

        return error
    }
}
