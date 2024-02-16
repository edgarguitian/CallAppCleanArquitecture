//
//  UserPranksStateView.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 9/2/24.
//

import SwiftUI

struct UserPranksStateView: View {
    let item: UserPrankPresentableItem

    var body: some View {
        switch item.state {
        case .enEjecucion:
            UserPrankStateEnEjecucion()
        case .noContestada:
            UserPrankStateNoContestada()
        case .programada:
            UserPrankStateProgramada()
        case .showButtons:
            UserPrankStateShowButtons(item: item)
        case .sinEstado:
            UserPrankStateSinEstado()
        }
    }
}

#Preview {
    VStack {
        UserPranksStateView(item: UserPrankPresentableItem.makePreviewMarihuana())
    }
}

struct UserPrankStateEnEjecucion: View {
    var body: some View {
        VStack {
            Text("En Ejecucion")
        }.padding()
    }
}

struct UserPrankStateNoContestada: View {
    var body: some View {
        VStack {
            Text("No Contestada")
        }.padding()
    }
}

struct UserPrankStateProgramada: View {
    var body: some View {
        VStack {
            Text("Programada")
        }.padding()
    }
}

struct UserPrankStateSinEstado: View {
    var body: some View {
        EmptyView()
    }
}

struct UserPrankStateShowButtons: View {
    let item: UserPrankPresentableItem
    private let soundPlayer = SoundPlayer()
    @State private var isPlaying = false

    var body: some View {
        HStack {

            Button(action: {
                // Hacer aqui las reactions
            }, label: {
                Image(systemName: "mic.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.redColorApp)
                    .padding()
            })

            if let grabacion = item.urlFile {
                Button(action: {
                    if isPlaying {
                        soundPlayer.stop()
                    } else {
                        soundPlayer.playAudio(withURL: grabacion)
                    }
                    isPlaying.toggle()
                }, label: {
                    Image(systemName: isPlaying ? "stop.circle.fill" : "play.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.redColorApp)
                        .padding()
                })
                .accessibilityIdentifier("btnPlayUserPrank")
            } else if let grabacion = item.grabacion {
                Button(action: {
                    if isPlaying {
                        soundPlayer.stop()
                    } else {
                        soundPlayer.playAudio(withURL: grabacion)
                    }
                    isPlaying.toggle()
                }, label: {
                    Image(systemName: isPlaying ? "stop.circle.fill" : "play.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.redColorApp)
                        .padding()
                })
                .accessibilityIdentifier("btnPlayUserPrank")
            }

            if let urlShare = item.urlFile {
                ShareLink(item: urlShare) {
                    Image(systemName: "square.and.arrow.up.circle.fill")
                        .resizable()
                }
                .frame(width: 30, height: 30)
                .padding()
                .accessibilityIdentifier("btnShareUserPrank")
                .accessibilityValue(item.id)
            } else if let urlShare = item.urlShare {
                ShareLink(item: urlShare) {
                    Image(systemName: "square.and.arrow.up.circle.fill")
                        .resizable()
                }
                .frame(width: 30, height: 30)
                .padding()
                .accessibilityIdentifier("btnShareUserPrank")
                .accessibilityValue(item.id)
            }
        }
        .onReceive(soundPlayer.didFinishPlaying) { _ in
            self.isPlaying = false
        }
    }
}
