//
//  MusicCell.swift
//  decibel
//
//  Created by Eldhose Lomy on 17/11/19.
//  Copyright © 2019 hacker.earth. All rights reserved.
//

import UIKit


class MusicCell: UITableViewCell {
    
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    func configure(with song: Track){
        artistNameLabel.text = song.artists
        songNameLabel.text = song.song
        artworkImageView.setRemoteImage(url: URL.init(string: song.image), placeholder: Constants.artworkPlaceholder, animation: .crossDissolve)
    }
}
