//
//  URLSessionRequestMaker.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 7/2/24.
//

import Foundation

class URLSessionRequestMaker {

    func urlRequest(endpoint: Endpoint, baseUrl: String) -> URLRequest? {
        // URL
        guard let url = URL(string: baseUrl) else { fatalError("Endpoint URL is invalid") }

        // URL Components
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.path = endpoint.path
        urlComponents?.queryItems = endpoint.queryParameters.map { URLQueryItem(name: $0.key, value: "\($0.value)")}

        guard let finalURL = urlComponents?.url else { fatalError("Endpoint path or query items are invalid") }
        // Request
        var request = URLRequest(url: finalURL)

        // Method
        request.httpMethod = endpoint.method.rawValue

        if endpoint.method == .post && endpoint.body != nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONSerialization.data(withJSONObject: endpoint.body!, options: .sortedKeys)
        }

        return request
    }
}
