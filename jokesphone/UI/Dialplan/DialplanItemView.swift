//
//  DialplanItemView.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 7/2/24.
//

import SwiftUI

struct DialplanItemView: View {
    let item: JokeDialplanPresentableItem
    let clearBackground: Bool
    private let soundPlayer = SoundPlayer()
    @State private var isPlaying = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                CachedAsyncImage(url: URL(string: item.image), urlCache: .imageCache) { phase in
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
                                AsyncImage(url: URL(string: item.image)) { image in
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
                    Text(item.titulo)
                        .font(.custom("Lato-Bold", size: 18))
                        .bold()
                        .foregroundColor(.redColorApp)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .minimumScaleFactor(0.5)

                        Text(item.desc)
                            .font(.custom("Lato-Regular", size: 13))
                            .foregroundColor(.descTextListado)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .minimumScaleFactor(0.5)

                }

                Spacer()

                if let grabacion = item.audioFile {
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
                    }).accessibilityIdentifier("btnPlayDialplan")
                }

            }
        }
        .padding(.vertical, 4)
        .background(clearBackground ? Color.clear : Color.listadoBackground)
        .frame(height: 88)
        .onReceive(soundPlayer.didFinishPlaying) { _ in
            self.isPlaying = false
        }
    }
}

#Preview {
    VStack {
        DialplanItemView(item: JokeDialplanPresentableItem.makePreview(), clearBackground: true)
        DialplanItemView(item: JokeDialplanPresentableItem.makePreviewManolete(), clearBackground: false)
        DialplanItemView(item: JokeDialplanPresentableItem.makePreviewRebajas(), clearBackground: true)
    }
}

extension JokeDialplanPresentableItem {
    static func makePreview() -> JokeDialplanPresentableItem {
        let desc = "Para conductores. Llamamos a tu amigo para decirle" +
        "que le ha cazado el radar a más velocidad de la permitida"
        let audiofile = "https://static.appha.es/mdbfs/jokesphone/pub/ESEjemploMulta.mp3"
        return JokeDialplanPresentableItem(id: "6002",
                                           audioFile: URL(string: audiofile)!,
                                    titulo: "Multa de Tráfico",
                                    image: "https://static.appha.es/mdbfs/jokesphone/pub/Denuncia_de_multa.jpg",
                                    desc: desc,
                                    enabled: true)
    }

    static func makePreviewManolete() -> JokeDialplanPresentableItem {
        let title = "El paquete de Manolete"
        let image = "https://static.appha.es/mdbfs/bromapp/pub/que_tenia_el_paquete.jpg"
        let desc = "Para todos los públicos. Vamos a hacerle esta rima a tu amigo, ¿qué apuestas a que cae?"
        let audioFile = "https://static.appha.es/mdbfs/jokesphone/pub/ESEjemploPaquete1.mp3"
        let id = "5005"
        return JokeDialplanPresentableItem(id: id,
                                           audioFile: URL(string: audioFile)!,
                                           titulo: title,
                                           image: image,
                                           desc: desc,
                                           enabled: true)
    }

    static func makePreviewRebajas() -> JokeDialplanPresentableItem {
        let title = "Las Rebajas de Enero - todo al 40 por ciento"
        let image = "https://static.appha.es/mdbfs/bromapp/pub/Las_Rebajas_de_Enero.jpg"
        let desc = "Para todos los públicos. Llamamos a tu amig@ para darle un " +
        "bono descuento del 40 por ciento ¿crees que lo aceptará?"
        let audioFile = "https://static.appha.es/mdbfs/jokesphone/pub/ESEjemploPaquete1.mp3"
        let id = "5005"
        return JokeDialplanPresentableItem(id: id,
                                           audioFile: URL(string: audioFile)!,
                                           titulo: title,
                                           image: image,
                                           desc: desc,
                                           enabled: true)
    }
}
