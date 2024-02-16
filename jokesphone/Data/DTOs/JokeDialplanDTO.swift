//
//  JokeDialplanDTO.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 7/2/24.
//

import Foundation

struct JokeDialplanDTO: Codable {
    let id: String
    let audioFile: String
    let titulo: String
    let image: String
    let desc: String
    let example: String
    let enabled: Bool

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case audioFile = "audiofile"
        case titulo, desc, example, enabled
        case image = "image_url"
    }
}
