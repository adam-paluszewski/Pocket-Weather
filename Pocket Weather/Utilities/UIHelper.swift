//
//  UIHelper.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 17/10/2022.
//

import UIKit
import AVKit
import WeatherKit


struct UIHelper {
    
    static func createAxialGradient(in view: UIView, startPoint: CGPoint, endPoint: CGPoint, colors: [CGColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        gradient.colors = colors
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.locations = [0, 0.1, 0.9, 1]
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    
    static func returnPlayerLayer(filename: String, in view: UIView) -> AVPlayerLayer {
        var player: AVPlayer?
        let videoURL = Bundle.main.url(forResource: filename, withExtension: "mp4")!
        
        player = AVPlayer(url: videoURL as URL)
        player?.actionAtItemEnd = .none
        player?.isMuted = true

        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer.zPosition = -1

        playerLayer.frame = view.frame
        player?.play()
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem, queue: nil) { _ in
                player?.seek(to: CMTime.zero)
                player?.play()
            }

        return playerLayer
    }
    
    
}
