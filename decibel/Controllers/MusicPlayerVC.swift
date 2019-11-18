//
//  MusicPlayerVC.swift
//  decibel
//
//  Created by Eldhose Lomy on 17/11/19.
//  Copyright © 2019 hacker.earth. All rights reserved.
//

import UIKit
import AVKit

class MusicPlayerVC: BaseVC {

    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var artworkBlurView: UIImageView!
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func setup() {
        super.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
    }
    
    func configureUI(){
        guard let song = AudioManager.shared.currentSong() else{
            print("Song Not Found")
            self.dismiss(animated: true, completion: nil)
            return
        }
        //Show Metadata
        songNameLabel.text = song.song
        artistLabel.text = song.artists
        artworkBlurView.setRemoteImage(url: URL.init(string: song.image), placeholder: Constants.artworkPlaceholder, animation: .none)
        artworkImageView.setRemoteImage(url: URL.init(string: song.image), placeholder: Constants.artworkPlaceholder, animation: .crossDissolve)
        //Update Controlls
        let controlImage = AudioManager.shared.isPlaying() ? Constants.pauseImage : Constants.playImage
        volumeSlider.setValue(AudioManager.shared.getVolume(), animated: false)
        playButton.setImage(controlImage, for: .normal)
        let favoriteImage = song.isFavorite ? Constants.favoriteImage : Constants.heartImage
        favoriteButton.setImage(favoriteImage, for: .normal)
        favoriteButton.tintColor = song.isFavorite ? UIColor.systemPink : UIColor.secondaryLabel
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == Constants.volumeObserverKey{
            guard let volume = change?[NSKeyValueChangeKey.newKey] as? Float else{
                return
            }
            volumeSlider?.setValue(volume, animated: true)
            AudioManager.shared.setVolume(volumeSlider.value)
        }
    }
    
    @IBAction func play(_ sender: UIButton){
        AudioManager.shared.toggle()
        let controlImage = AudioManager.shared.isPlaying() ? Constants.pauseImage : Constants.playImage
        playButton.setImage(controlImage, for: .normal)
    }
    
    @IBAction func next(_ sender: UIButton){
        AudioManager.shared.next()
        configureUI()
    }
    
    @IBAction func previous(_ sender: UIButton){
        AudioManager.shared.previous()
        configureUI()
    }
    
    @IBAction func volumeChanged(_ sender: UISlider){
        AudioManager.shared.setVolume(volumeSlider.value)
    }
 
    @IBAction func favorite(_ sender: UIButton){
        guard let song = AudioManager.shared.currentSong() else{
            return
        }
        let isFavorite = song.isFavorite ? false : true
        song.favorite(enable: isFavorite)
        let favoriteImage = song.isFavorite ? Constants.favoriteImage : Constants.heartImage
        favoriteButton.setImage(favoriteImage, for: .normal)
        favoriteButton.tintColor = song.isFavorite ? UIColor.systemPink : UIColor.secondaryLabel
    }
    
    @IBAction func download(_ sender: UIButton){
        let paymentVC = storyboard?.instantiateViewController(identifier: PaymentVC.storyboardID)
        self.present(paymentVC!, animated: true, completion: nil)
    }
}
