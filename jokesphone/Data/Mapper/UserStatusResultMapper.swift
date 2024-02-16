//
//  UserStatusResultMapper.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import Foundation

class UserStatusResultMapper {
    func map(result: UserStatusDTO) -> UserStatus {
        return UserStatus(res: result.res,
                          version: result.version,
                          banned: result.banned,
                          admob: result.admob,
                          hasPromo: result.hasPromo,
                          mgmMethod: result.mgmMethod,
                          showlegal: result.showlegal,
                          country: result.country,
                          joinIos: result.joinIos,
                          registerIos: result.registerIos,
                          smsFirebaseIos: result.smsFirebaseIos,
                          recLocalIos: result.recLocalIos,
                          showreactionIos: result.showreactionIos,
                          mgmFreejokesUser: result.mgmFreejokesUser,
                          mgmFreejokesFriend: result.mgmFreejokesFriend,
                          loginFbIos: result.loginFbIos,
                          enabled: result.enabled,
                          amd: result.amd,
                          shareURL: result.shareURL)
    }
}
