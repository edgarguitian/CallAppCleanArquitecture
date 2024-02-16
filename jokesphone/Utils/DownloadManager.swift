//
//  DownloadManager.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 14/2/24.
//

import Foundation
import AVFoundation

final class DownloadManager: ObservableObject {
    @Published var isDownloading = false
    @Published var isDownloaded = false
    static let shared = DownloadManager()

    func downloadFile(idJoke: String, urlJoke: URL) {
        isDownloading = true

        let docsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first

        let destinationUrl = docsUrl?.appendingPathComponent(idJoke+".mp3")

        if let destinationUrl = destinationUrl {
            if FileManager().fileExists(atPath: destinationUrl.path) {
                print("File already exists")
                isDownloading = false
            } else {
                let urlRequest = URLRequest(url: urlJoke)

                let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                    if let error = error {
                        print("Request error: ", error)
                        self.isDownloading = false
                        return
                    }

                    guard let response = response as? HTTPURLResponse else { return }

                    if response.statusCode == 200 {
                        guard let data = data else {
                            self.isDownloading = false
                            return
                        }
                        DispatchQueue.main.async {
                            do {
                                try data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
                                DispatchQueue.main.async {
                                    self.isDownloading = false
                                    UserDefaultsManager.shared.setIsDownloaded(forKey: idJoke)
                                }
                            } catch let error {
                                print("Error decoding: ", error)
                                self.isDownloading = false
                            }
                        }
                    }
                }
                dataTask.resume()
            }
        }
    }

    func checkFileExists(idJoke: String) -> Bool {
        let docsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first

        let destinationUrl = docsUrl?.appendingPathComponent(idJoke+".mp3")
        if let destinationUrl = destinationUrl {
            if FileManager().fileExists(atPath: destinationUrl.path) {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }

    func getUrlFile(idJoke: String) -> URL? {
        let docsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first

        let destinationUrl = docsUrl?.appendingPathComponent(idJoke+".mp3")
        return destinationUrl
    }
}
