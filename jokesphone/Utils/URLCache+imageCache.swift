//
//  URLCache+imageCache.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 7/2/24.
//

import Foundation

extension URLCache {

    static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 10_000_000_000)
}
