//
//  UserPrankPresentableItem.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 9/2/24.
//

import Foundation

struct UserPrankPresentableItem {
    let id: String
    let dateNum: Int
    let returned: Bool
    let dateString: String
    let title: String
    let grabacion: URL?
    let dst: String
    let name: String
    let done: Bool
    let pic: String
    let started: Bool
    let queued: Bool
    let uid: String
    let gnt: Bool
    let state: UserPrankState
    let urlShare: URL?
    var urlFile: URL?
}

enum UserPrankState {
    case showButtons
    case noContestada
    case enEjecucion
    case programada
    case sinEstado
}

extension UserPrankPresentableItem: Hashable {

}

extension UserPrankPresentableItem {
    static func makeUserPranksPresentable() -> [UserPrankPresentableItem] {
        var result: [UserPrankPresentableItem] = []
        result.append(
            UserPrankPresentableItem(
                id: "1", dateNum: 0,
                returned: false, dateString: "antes",
                title: "title1", grabacion: URL(string: "grabacion1"),
                dst: "dst1", name: "name1", done: true, pic: "pic1",
                started: true,
                queued: false,
                uid: "uid1",
                gnt: false, state: UserPrankState.enEjecucion,
                urlShare: nil, urlFile: nil
            )
        )
        result.append(
            UserPrankPresentableItem(
                id: "2", dateNum: 0,
                returned: false, dateString: "ahora",
                title: "title2", grabacion: URL(string: "grabacion2"),
                dst: "dst2", name: "name2", done: true, pic: "pic2",
                started: true,
                queued: false,
                uid: "uid2",
                gnt: false, state: UserPrankState.noContestada,
                urlShare: nil, urlFile: nil
            )
        )
        result.append(
            UserPrankPresentableItem(
                id: "3", dateNum: 0,
                returned: false, dateString: "despues",
                title: "title3", grabacion: URL(string: "grabacion3"),
                dst: "dst3", name: "name3", done: true,
                pic: "pic3",
                started: true,
                queued: false,
                uid: "uid3",
                gnt: false, state: UserPrankState.showButtons,
                urlShare: nil, urlFile: nil
            )
        )
        return result
    }
}
