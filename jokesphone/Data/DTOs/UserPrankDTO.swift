//
//  UserPrankDTO.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 8/2/24.
//

import Foundation

struct UserPrankDTO: Codable {
    let id: String
    let dateNum: Int
    let returned: Bool
    let cou: String
    let dateString: String
    let realDateString: String
    let title: String
    let grabacion: String
    let dst: String
    let name: String
    let dial: String
    let done: Bool?
    let visible: Bool
    let pic: String
    let started: Bool?
    let queued: Bool
    let uid: String
    let gnt: Bool
    let rmv: Bool?
    let amd: Bool?
    let contestador: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case dateNum = "f"
        case returned, cou, dst, dial, done, visible
        case pic, started, queued, uid, gnt, rmv, amd, contestador
        case dateString = "fecha"
        case realDateString = "real_f"
        case title = "titulo"
        case grabacion = "url"
        case name = "nombre"

    }
}
