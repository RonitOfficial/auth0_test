//
//  VideoPlayer.swift
//  ios-auth0-app-dev
//
//  Created by Ronit Maitra on 25/08/22.
//

import Foundation
import AVKit
import SwiftUI

class LoopVideoPlayerUIView: UIView{
    var videoUrl: String
    
    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, videoUrl: String) {
        self.videoUrl = videoUrl
        super.init(frame: frame)
        
        let asset: AVAsset?
        if let url = URL(string: videoUrl){
            asset = AVAsset(url: url)
        }else{
            asset = AVAsset(url: Bundle.main.url(forResource: "chameleon1", withExtension: "mp4")!)
        }
        
        let item = AVPlayerItem(asset: asset!)
        let player = AVQueuePlayer()
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspect
        playerLayer.player?.volume = 0
        playerLayer.player?.actionAtItemEnd = .none
        layer.addSublayer(playerLayer)
        
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
        player.play()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

struct CustomVideoPlayer: UIViewRepresentable{
    @State var videoUrl: String
    
    func makeUIView(context: Context) -> UIView {
        return LoopVideoPlayerUIView(frame: .zero, videoUrl: self.videoUrl)
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<CustomVideoPlayer>) {
    }
}
