//
//  MiniPlayerView.swift
//  decibel
//
//  Created by Eldhose Lomy on 17/11/19.
//  Copyright © 2019 hacker.earth. All rights reserved.
//

import UIKit

class MiniPlayerView: UIVisualEffectView{
    
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    
    func configure(with song: Track){
        songNameLabel.text = song.song
        artworkImageView.setRemoteImage(url: URL.init(string: song.image), placeholder: Constants.artworkPlaceholder, animation: .crossDissolve)
        let controlImage = AudioManager.shared.isPlaying() ? Constants.pauseImage : Constants.playImage
        playButton.setImage(controlImage, for: .normal)
    }
    
    @IBAction func play(_ sender: UIButton){
        AudioManager.shared.toggle()
        let controlImage = AudioManager.shared.isPlaying() ? Constants.pauseImage : Constants.playImage
        playButton.setImage(controlImage, for: .normal)
    }
}
