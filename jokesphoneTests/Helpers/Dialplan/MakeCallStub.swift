//
//  MakeCallStub.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 16/2/24.
//

import Foundation
@testable import jokesphone

class MakeCallStub: MakeCallType {
    private let isSuccess: Bool

    init(isSuccess: Bool) {
        self.isSuccess = isSuccess
    }

    func execute(title: String,
                 dial: String,
                 dstCall: String,
                 name: String) async -> Result<MakeCallResult, JokesPhoneDomainError> {
        if isSuccess {
            return .success(MakeCallResult.makeCallResult())
        } else {
            return .failure(.generic)
        }
    }
}
