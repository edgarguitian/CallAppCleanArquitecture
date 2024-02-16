//
//  MainView.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 7/2/24.
//

import SwiftUI

struct MainView: View {
    let dialplan: DialplanView
    let userPranks: UserPranksView

    var body: some View {
        TabView {
            Group {
                dialplan.tabItem {
                    Label("Listado", systemImage: "list.bullet.clipboard")
                        .accessibilityIdentifier("tabDialplan")
                }

                userPranks.tabItem {
                    Label("Mis Llamadas", systemImage: "backward.circle")
                        .accessibilityIdentifier("tabUserPranks")
                }
            }
            // .toolbar(.visible, for: .tabBar)
            // .toolbarBackground(.clear, for: .tabBar)
        }
    }
}

#Preview {
    MainView(dialplan: DialplanFactory.create(),
             userPranks: UserPrankFactory.create())
}
