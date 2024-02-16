//
//  UserPrankPresentableMapper.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 9/2/24.
//

import Foundation

class UserPrankPresentableMapper {
    func map(items: [UserPrank]) -> [UserPrankPresentableItem] {
        var result: [UserPrankPresentableItem] = []
        for userPranks in items {

            var item = UserPrankPresentableItem(id: userPranks.id,
                                                dateNum: userPranks.dateNum,
                                                returned: userPranks.returned,
                                                dateString: userPranks.dateString,
                                                title: userPranks.title,
                                                grabacion: URL(string: userPranks.grabacion) ?? nil,
                                                dst: userPranks.dst,
                                                name: userPranks.name,
                                                done: userPranks.done,
                                                pic: userPranks.pic,
                                                started: userPranks.started,
                                                queued: userPranks.queued,
                                                uid: userPranks.uid,
                                                gnt: userPranks.gnt,
                                                state: getStateUserPrank(userPrank: userPranks),
                                                urlShare: buildUrlShare(withId: userPranks.id),
                                                urlFile: nil)
            if !DownloadManager.shared.checkFileExists(idJoke: item.id) {
                if let grabacion = item.grabacion {
                    DownloadManager.shared.downloadFile(idJoke: item.id, urlJoke: grabacion)
                }
            } else {
                item.urlFile = DownloadManager.shared.getUrlFile(idJoke: item.id)
            }
            result.append(item)

        }
        return result
    }

    func getStateUserPrank(userPrank: UserPrank) -> UserPrankState {
        let hayUrl = !userPrank.grabacion.isEmpty && !userPrank.grabacion.contains("phone_banned")
        let yadescargado = UserDefaultsManager.shared.getIsDownloaded(idJoke: userPrank.id)

        if hayUrl {
            return UserPrankState.showButtons
        } else if userPrank.returned {
            return UserPrankState.noContestada
        } else if !hayUrl && !userPrank.returned && !yadescargado {
            return UserPrankState.sinEstado
        } else {
            return UserPrankState.enEjecucion
        }
    }

    func buildUrlShare(withId: String) -> URL? {
        guard !withId.isEmpty else {
            return nil
        }
        var urlString = UserDefaultsManager.shared.shareURL ?? ""
        urlString.append(withId)
        print(urlString)
        return URL(string: urlString)
    }
}
