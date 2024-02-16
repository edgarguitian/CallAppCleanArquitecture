//
//  CallResultMapper.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 8/2/24.
//

import Foundation

class CallResultMapper {
    func map(result: MakeCallResultDTO) -> MakeCallResult {
        var resultCall = true
        if result.res == "KO" {
            resultCall = false
        }
        return MakeCallResult(res: resultCall, content: result.content)
    }
}
