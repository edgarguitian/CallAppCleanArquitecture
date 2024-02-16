//
//  APIUserPranksDataSourceType.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 9/2/24.
//

import Foundation

protocol APIUserPranksDataSourceType {
    func getUserPranks() async -> Result<[UserPrankDTO], HTTPClientError>
}
