//
//  UserCreditResultMapper.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import Foundation

class UserCreditResultMapper {
    func map(result: UserCreditDTO) -> UserCredit {
        return UserCredit(res: result.res,
                          credit: result.credit)
    }
}
