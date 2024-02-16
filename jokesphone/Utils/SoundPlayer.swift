//
//  SoundPlayer.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import Foundation
import AVFAudio
import AVFoundation

class SoundPlayer {
    var playerItem: AVPlayerItem?
    var player: AVPlayer?
    let didFinishPlaying = NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)

    func playAudio(withURL url: URL) {
        playerItem = AVPlayerItem(url: url)
        if let error = playerItem?.error {
            print("Error al crear AVPlayerItem:", error.localizedDescription)
            return
        }
        player = AVPlayer(playerItem: playerItem)
        if let error = player?.error {
            print("Error al crear AVPlayer:", error.localizedDescription)
            return
        }

        player?.play()
    }

    func stop() {
        player?.pause()
    }
}
