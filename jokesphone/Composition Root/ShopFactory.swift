//
//  ShopFactory.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import Foundation

class ShopFactory: CreateShopView {
    func create() -> ShopView {
        return ShopView()
    }
}
