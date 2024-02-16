//
//  APIUserStatusDataSourceType.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import Foundation

protocol APIUserStatusDataSourceType {
    func getUserStatus() async -> Result<UserStatusDTO, HTTPClientError>
}
