//
//  Endpoint.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 7/2/24.
//

import Foundation

struct Endpoint {
    let path: String
    let queryParameters: [String: Any]
    let body: [String: Any]?
    let method: HTTPMethod
}
