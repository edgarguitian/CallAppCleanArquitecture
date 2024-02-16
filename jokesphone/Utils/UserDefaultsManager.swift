//
//  UserDefaultsManager.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()

    private let userDefaults = UserDefaults.standard

    var recLocalIos: Bool? {
        get {
            return userDefaults.bool(forKey: "reclocal")
        }
        set {
            userDefaults.setValue(newValue, forKey: "reclocal")
            userDefaults.synchronize()
        }
    }

    var shareURL: String? {
        get {
            return userDefaults.string(forKey: "shareurl")
        }
        set {
            userDefaults.setValue(newValue, forKey: "shareurl")
            userDefaults.synchronize()
        }
    }

    func setIsDownloaded(forKey idJoke: String) {
        userDefaults.set(true, forKey: "jokesphone" + idJoke)
        userDefaults.synchronize()
    }

    func getIsDownloaded(idJoke: String) -> Bool {
        return userDefaults.bool(forKey: "jokesphone" + idJoke)
    }
}
