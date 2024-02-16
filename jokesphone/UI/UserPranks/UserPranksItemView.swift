//
//  UserPranksItemView.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 9/2/24.
//

import SwiftUI

struct UserPranksItemView: View {
    let item: UserPrankPresentableItem
    let clearBackground: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                CachedAsyncImage(url: URL(string: item.pic), urlCache: .imageCache) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 84, height: 88)
                                    .clipShape(RoundedRectangle(cornerRadius: 0))
                                    .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.red, lineWidth: 3))

                            case .failure:
                                AsyncImage(url: URL(string: item.pic)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                } placeholder: {
                                    ProgressView()
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 35))
                                .padding(.vertical)
                            @unknown default:
                                fatalError()
                            }
                        }

                VStack(alignment: .leading) {
                    Text(item.dst)
                        .font(.custom("Lato-Bold", size: 18))
                        .foregroundColor(.redColorApp)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .minimumScaleFactor(0.5)
                        .padding(.bottom, 5)

                    Text(item.title)
                        .font(.custom("Lato-Bold", size: 15))
                        .bold()
                        .foregroundColor(.descTextListado)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .minimumScaleFactor(0.5)
                        .padding(.bottom, 5)
                        .accessibilityIdentifier("itemViewUserPrankTitle")
                        .accessibilityValue(item.id)

                    Text(item.dateString)
                        .font(.custom("Lato-Regular", size: 13))
                        .foregroundColor(.descTextListado)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .minimumScaleFactor(0.5)

                }

                Spacer()

                UserPranksStateView(item: item)

            }
        }
        .padding(.vertical, 4)
        .background(clearBackground ? Color.clear : Color.listadoBackground)
        .frame(height: 88)
    }
}

#Preview {
    VStack {
        UserPranksItemView(item: UserPrankPresentableItem.makePreviewMulta(), clearBackground: true)
        UserPranksItemView(item: UserPrankPresentableItem.makePreviewMarihuana(), clearBackground: false)
    }
}

extension UserPrankPresentableItem {
    static func makePreviewMulta() -> UserPrankPresentableItem {
        let pic = "https://static.appha.es/mdbfs/bromapp/pub/Denuncia_de_multa.jpg"
        let url = "https://cdn.appha.es/jokesphone/bromas/2024-2/8/lSN727BG1wiyFJa7vA.mp3"
        return UserPrankPresentableItem(id: "lSN727BG1wiyFJa7vA",
                                        dateNum: 1707417256,
                                        returned: false,
                                        dateString: "2024-02-08 19:33:37",
                                        title: "Multa de Tráfico",
                                        grabacion: URL(string: url),
                                        dst: "??????",
                                        name: "Test",
                                        done: true,
                                        pic: pic,
                                        started: true,
                                        queued: true,
                                        uid: "",
                                        gnt: false,
                                        state: UserPrankState.noContestada,
                                        urlShare: nil)
    }

    static func makePreviewMarihuana() -> UserPrankPresentableItem {
        let pic = "https://static.appha.es/mdbfs/bromapp/pub/maria.jpg"
        let url = "https://master.appha.es/lua/jokesphone/phone_banned?phone=????"
        return UserPrankPresentableItem(id: "AG2NKc7kl6czVzdWvG",
                                        dateNum: 1702416523,
                                        returned: false,
                                        dateString: "2023-12-12 22:28:43",
                                        title: "Olor a Marihuana",
                                        grabacion: URL(string: url),
                                        dst: "??????",
                                        name: "Test",
                                        done: true,
                                        pic: pic,
                                        started: true,
                                        queued: true,
                                        uid: "",
                                        gnt: false,
                                        state: UserPrankState.showButtons,
                                        urlShare: nil)
    }
}
