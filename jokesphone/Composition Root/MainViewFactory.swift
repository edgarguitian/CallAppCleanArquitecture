//
//  MainViewFactory.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import Foundation

class MainViewFactory: CreateMainView {
    func create() -> MainView {
        return MainView(dialplan: DialplanFactory.create(),
                        userPranks: UserPrankFactory.create())
    }
}
