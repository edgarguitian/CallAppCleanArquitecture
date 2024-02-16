//
//  APIDialplanDataSource.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 7/2/24.
//

import Foundation

class APIDialplanDataSource: APIDialplanDataSourceType {
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    func getDialplan() async -> Result<[JokeDialplanDTO], HTTPClientError> {
        let body: [String: Any] = [
            "c": "es",
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

        guard let dialplanResponse = try? JSONDecoder().decode([JokeDialplanDTO].self, from: data) else {
            return .failure(.parsingError)
        }
        return .success(dialplanResponse)
    }

    private func handleError(error: HTTPClientError?) -> HTTPClientError {
        guard let error = error else {
            return .generic
        }

        return error
    }
}
