//
//  VideoBackgroundManager.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 19/10/2022.
//

import AVKit
import UIKit


class VideoBackgroundManager {
    var player: AVPlayer?
    var isVideonEndingBeingObserved = false
    
    func returnPlayerLayer(in view: UIView, with filename: String) -> AVPlayerLayer {
        let videoURL = Bundle.main.url(forResource: filename, withExtension: "mp4")!
        player = AVPlayer(url: videoURL as URL)
        player?.actionAtItemEnd = .none
        player?.isMuted = true

        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer.zPosition = -1

        playerLayer.frame = view.frame
        player?.play()
        
        addObserverForPlayerEnding()

        
        return playerLayer
    }
    
    
    func addObserverForPlayerEnding() {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem, queue: nil) { _ in
            self.player?.seek(to: CMTime.zero)
            self.player?.play()
            }
    }
}
