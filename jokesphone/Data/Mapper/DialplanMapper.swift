//
//  DialplanMapper.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 7/2/24.
//

import Foundation

class DialplanMapper {
    func map(items: [JokeDialplanDTO]) -> [JokeDialplan] {
        var result: [JokeDialplan] = []
        for jokeDialplan in items {
            let item = JokeDialplan(id: jokeDialplan.id,
                                    audiofile: jokeDialplan.audioFile,
                                    titulo: jokeDialplan.titulo,
                                    image: jokeDialplan.image,
                                    description: jokeDialplan.desc,
                                    example: jokeDialplan.example,
                                    hits: 0,
                                    enabled: jokeDialplan.enabled)
            result.append(item)
        }
        return result
    }
}
