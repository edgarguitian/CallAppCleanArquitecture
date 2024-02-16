//
//  APIUserStatusDataSource.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import Foundation

class APIUserStatusDataSource: APIUserStatusDataSourceType {
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    func getUserStatus() async -> Result<UserStatusDTO, HTTPClientError> {
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

        // print(String(decoding: data, as: UTF8.self))

        guard let userStatusResponse = try? JSONDecoder().decode(UserStatusDTO.self, from: data) else {
            return .failure(.parsingError)
        }
        return .success(userStatusResponse)
    }

    private func handleError(error: HTTPClientError?) -> HTTPClientError {
        guard let error = error else {
            return .generic
        }

        return error
    }
}
