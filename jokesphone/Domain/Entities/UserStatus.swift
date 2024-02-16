//
//  UserStatus.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import Foundation

struct UserStatus {
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
}
