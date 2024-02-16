//
//  APIMakeCallDataSourceType.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 8/2/24.
//

import Foundation

protocol APIMakeCallDataSourceType {
    func makeCall(title: String,
                  dial: String,
                  dstCall: String,
                  name: String) async -> Result<(String, MakeCallResultDTO), HTTPClientError>
}
