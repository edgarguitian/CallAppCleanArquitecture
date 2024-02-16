//
//  MakeCallResultDTO.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 8/2/24.
//

import Foundation

struct MakeCallResultDTO: Codable {
    let res: String
    let content: String?

    enum CodingKeys: String, CodingKey {
        case res, content
    }
}
