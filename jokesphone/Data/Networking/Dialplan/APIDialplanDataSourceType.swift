//
//  APIDialplanDataSourceType.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 7/2/24.
//

import Foundation

protocol APIDialplanDataSourceType {
    func getDialplan() async -> Result<[JokeDialplanDTO], HTTPClientError>
}
