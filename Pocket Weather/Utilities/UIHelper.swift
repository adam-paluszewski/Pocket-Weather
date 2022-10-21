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
    
    
    static func addGradientAnimation(in view: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.frame
        gradientLayer.zPosition = -1
        view.layer.addSublayer(gradientLayer)

        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = [UIColor(red: 68/255, green: 149/255, blue: 230/255, alpha: 1).cgColor, UIColor(red: 171/255, green: 203/255, blue: 235/255, alpha: 1).cgColor]
        animation.toValue = [UIColor(red: 46/255, green: 104/255, blue: 161/255, alpha: 1).cgColor, UIColor(red: 138/255, green: 150/255, blue: 162/255, alpha: 1).cgColor]
        animation.duration = 1
        gradientLayer.add(animation, forKey: nil)
        
        gradientLayer.colors = [UIColor(red: 46/255, green: 104/255, blue: 161/255, alpha: 1).cgColor, UIColor(red: 138/255, green: 150/255, blue: 162/255, alpha: 1).cgColor]
    }
}
