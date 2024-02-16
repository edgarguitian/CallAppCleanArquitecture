//
//  Equatable.swift
//  jokesphoneTests
//
//  Created by Edgar Guitian Rey on 14/2/24.
//

import Foundation
@testable import jokesphone

extension UserStatus: Equatable {
    public static func == (lhs: UserStatus, rhs: UserStatus) -> Bool {
        return lhs.joinIos == rhs.joinIos &&
        lhs.recLocalIos == rhs.recLocalIos &&
        lhs.shareURL == rhs.shareURL
    }

}
