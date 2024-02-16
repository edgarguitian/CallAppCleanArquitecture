//
//  JokeDialplanPresentableItem.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 7/2/24.
//

import Foundation

struct JokeDialplanPresentableItem {
    let id: String
    let audioFile: URL?
    let titulo: String
    let image: String
    let desc: String
    let enabled: Bool
}

extension JokeDialplanPresentableItem: Hashable {

}

extension JokeDialplanPresentableItem {
    static func makeDialplanPresentable() -> [JokeDialplanPresentableItem] {
        var result: [JokeDialplanPresentableItem] = []
        result.append(
            JokeDialplanPresentableItem(
                id: "1",
                audioFile: URL(string: "audioFile1"),
                titulo: "titulo1",
                image: "image1",
                desc: "desc1",
                enabled: true
            )
        )
        result.append(
            JokeDialplanPresentableItem(
                id: "3",
                audioFile: URL(string: "audioFile3"),
                titulo: "titulo3",
                image: "image3",
                desc: "desc3",
                enabled: true
            )
        )
        return result
    }
}
