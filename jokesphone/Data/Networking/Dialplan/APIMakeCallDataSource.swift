//
//  APIMakeCallDataSource.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 8/2/24.
//

import Foundation

class APIMakeCallDataSource: APIMakeCallDataSourceType {
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    func makeCall(title: String,
                  dial: String,
                  dstCall: String,
                  name: String) async -> Result<(String, MakeCallResultDTO), HTTPClientError> {
        let date24 = formatDateTo24Hours()
        let date24f = formatDateTo24HoursWithFormat(date: Date(), format: "dd-MM-yyy'T'H:mm:ss")
        let identificador = randomStringWithLength(18)

        let body: [String: Any] = [
            "_id": identificador,
            "titulo": title,
            "dial": dial,
            "dst": dstCall,
            "nombre": name,
            "c": "es",
            "f": date24f,
            "real_f": date24,
            "lpd": true,
            "uid": ""
        ]

        let queryParameters: [String: Any] = [:]

        let endpoint = Endpoint(path: "",
                                queryParameters: queryParameters,
                                body: body,
                                method: .post)

        let result = await httpClient.makeRequest(endpoint: endpoint, baseUrl: "")

        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }

        guard let makeCallResponse = try? JSONDecoder().decode(MakeCallResultDTO.self, from: data) else {
            return .failure(.parsingError)
        }
        return .success((identificador, makeCallResponse))
    }

    private func handleError(error: HTTPClientError?) -> HTTPClientError {
        guard let error = error else {
            return .generic
        }

        return error
    }

    private func randomStringWithLength(_ len: Int) -> String {

        let letters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

        let randomString = NSMutableString(capacity: len)

        for _ in 1...len {
            randomString.appendFormat("%C", letters.character(at: Int(arc4random_uniform(UInt32(letters.length)))))
        }

        return randomString as String
    }

    private func formatDateTo24Hours() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy-MM-dd H:mm:ss"
        dateFormatter.locale = Locale(identifier: "es_ES_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "Europe/Madrid")
        return dateFormatter.string(from: Date())
    }

    private func formatDateTo24HoursWithFormat(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "es_ES_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "Europe/Madrid")
        return dateFormatter.string(from: date)
    }
}
