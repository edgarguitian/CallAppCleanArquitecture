//
//  HTTPClient.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 7/2/24.
//

import Foundation

protocol HTTPClient {
    func makeRequest(endpoint: Endpoint, baseUrl: String) async -> Result<Data, HTTPClientError>
}
