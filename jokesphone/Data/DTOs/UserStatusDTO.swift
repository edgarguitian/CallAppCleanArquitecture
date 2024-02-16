//
//  UserStatusDTO.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import Foundation

struct UserStatusDTO: Codable {
    let res: String
    let version: Int
    let banned, admob, hasPromo: Bool
    let mgmMethod: String
    let showlegal: Bool
    let country: String
    let joinIos: Bool
    let registerIos: String
    let smsFirebaseIos, recLocalIos, showreactionIos: Bool
    let mgmFreejokesUser, mgmFreejokesFriend: Int
    let loginFbIos, enabled: Bool
    let amd: String
    let shareURL: String

    enum CodingKeys: String, CodingKey {
        case res, version, banned, admob
        case hasPromo = "has_promo"
        case mgmMethod = "mgm_method"
        case showlegal, country
        case joinIos = "join_ios"
        case registerIos = "register_ios"
        case smsFirebaseIos = "sms_firebase_ios"
        case recLocalIos = "rec_local_ios"
        case showreactionIos = "showreaction_ios"
        case mgmFreejokesUser = "mgm_freejokes_user"
        case mgmFreejokesFriend = "mgm_freejokes_friend"
        case loginFbIos = "login_fb_ios"
        case enabled, amd
        case shareURL = "share_url"
    }
}
