//
//  APIUserPranksDataSource.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 9/2/24.
//

import Foundation

class APIUserPranksDataSource: APIUserPranksDataSourceType {
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    func getUserPranks() async -> Result<[UserPrankDTO], HTTPClientError> {
        let body: [String: Any] = [
            "c": "es",
            "lpd": true,
            "uid": ""
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

        guard let userPranksResponse = try? JSONDecoder().decode([UserPrankDTO].self, from: data) else {
            return .failure(.parsingError)
        }
        return .success(userPranksResponse)
    }

    private func handleError(error: HTTPClientError?) -> HTTPClientError {
        guard let error = error else {
            return .generic
        }

        return error
    }
}
