//
//  UserCreditDTO.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import Foundation

struct UserCreditDTO: Codable {
    let res: String
    let credit: Int
    enum CodingKeys: String, CodingKey {
        case res, credit
    }
}
