//
//  APIUserCreditDataSourceType.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import Foundation

protocol APIUserCreditDataSourceType {
    func getUserCredit() async -> Result<UserCreditDTO, HTTPClientError>
}
