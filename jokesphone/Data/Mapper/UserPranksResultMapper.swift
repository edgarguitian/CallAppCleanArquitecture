//
//  UserPranksResultMapper.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 9/2/24.
//

import Foundation

class UserPranksResultMapper {
    func map(result: [UserPrankDTO]) -> [UserPrank] {
        var resultMap: [UserPrank] = []
        for userPrank in result {
            let userPrankDomain = UserPrank(id: userPrank.id, dateNum: userPrank.dateNum,
                                            returned: userPrank.returned, cou: userPrank.cou,
                                            dateString: userPrank.dateString, realDateString: userPrank.realDateString,
                                            title: userPrank.title, grabacion: userPrank.grabacion,
                                            dst: userPrank.dst, name: userPrank.name,
                                            dial: userPrank.dial, done: userPrank.done ?? true,
                                            visible: userPrank.visible, pic: userPrank.pic,
                                            started: userPrank.started ?? false, queued: userPrank.queued,
                                            uid: userPrank.uid, gnt: userPrank.gnt)
            if userPrankDomain.visible {
                resultMap.append(userPrankDomain)
            }
        }
        return resultMap
    }
}
