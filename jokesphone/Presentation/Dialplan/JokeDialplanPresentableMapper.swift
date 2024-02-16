//
//  JokeDialplanPresentableMapper.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 8/2/24.
//

import Foundation

class JokeDialplanPresentableMapper {
    func map(items: [JokeDialplan]) -> [JokeDialplanPresentableItem] {
        var result: [JokeDialplanPresentableItem] = []
        for jokeDialplan in items {
            let item = JokeDialplanPresentableItem(id: jokeDialplan.id,
                                                   audioFile: URL(string: jokeDialplan.example) ?? nil,
                                            titulo: jokeDialplan.titulo,
                                            image: jokeDialplan.image,
                                            desc: jokeDialplan.description,
                                            enabled: jokeDialplan.enabled)
            if item.enabled {
                result.append(item)
            }

        }
        return result
    }
}
