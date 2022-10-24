//
//  VideoBackgroundManager.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 19/10/2022.
//

import AVFoundation
import UIKit


class VideoBackgroundManager {
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var isVideonEndingBeingObserved = false
    
    func addPlayerLayer(in view: UIView, with filename: String) {
        
        let videoURL = Bundle.main.url(forResource: filename, withExtension: "mp4")!
        player = AVPlayer(url: videoURL as URL)
        player?.actionAtItemEnd = .none
        player?.isMuted = true
        
        if let playerLayer = playerLayer {
            view.layer.sublayers?.removeAll(where: { layer in
                layer is AVPlayerLayer
            })
        }
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer?.zPosition = -1

        playerLayer?.frame = view.frame
        
        player?.play()
        
        addObserverForPlayerEnding()
        
        playerLayer?.opacity = 0
        
        view.layer.addSublayer(playerLayer!)

        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1
        playerLayer?.add(animation, forKey: nil)
        
        playerLayer?.opacity = 1
    }
    
    
    func addObserverForPlayerEnding() {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem, queue: nil) { _ in
            self.player?.seek(to: CMTime.zero)
            self.player?.play()
            }
    }
    
    
}
