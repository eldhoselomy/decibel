//
//  AudioManager.swift
//  decibel
//
//  Created by Eldhose Lomy on 17/11/19.
//  Copyright © 2019 hacker.earth. All rights reserved.
//

import Foundation
import MediaPlayer
import AVKit

class AudioManager{
    
    static let shared = AudioManager()
    private var player: AVQueuePlayer!
    private init() { player = AVQueuePlayer() }
    private var library: [Track] = []
    private var allSongs: [Track] = []
    private var allPlayerItems: [AVPlayerItem] = []
    
    func playAudio(songs: [Track]){
        allSongs = songs
        allPlayerItems =  songs.map{  URL.init(string: $0.url) }
            .compactMap{ $0 }
            .map{ AVPlayerItem.init(url: $0) }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            player = AVQueuePlayer(items: allPlayerItems)
            player.volume = AVAudioSession.sharedInstance().outputVolume
            player.automaticallyWaitsToMinimizeStalling = false
            player.play()
            UIApplication.shared.beginReceivingRemoteControlEvents()
            RemoteCommanadManager.shared.setupNowPlaying()
        }catch{
            print(error)
            print("Unable to Play")
        }
    }
    
    func play(){
        player.play()
    }
    
    func pause(){
        player.pause()
    }
    
    func toggle(){
        _ = isPlaying() ? pause() : play()
    }
    
    func isPlaying()->Bool{
        return player.isPlaying
    }
    
    func next(){
        player.advanceToNextItem()
        RemoteCommanadManager.shared.setupNowPlaying()
    }
    
    func previous(){
        if let currentItem = player.currentItem, let index: Int = allPlayerItems.firstIndex(of: currentItem){
            player.advanceToPreviousItem(for: index, with: allPlayerItems)
            RemoteCommanadManager.shared.setupNowPlaying()
        }
    }
    
    func currentSong()->Track?{
        if let currentItem = player.currentItem, let index: Int = allPlayerItems.firstIndex(of: currentItem){
            return allSongs[index]
        }
        return nil
    }
    
    func setVolume(_ volume: Float){
        MPVolumeView.setVolume(volume)
        player.volume = volume
    }
    
    func getVolume()->Float{
        return player.volume
    }
    
    func getLibrary()->[Track]{
        return library
    }
    
    func setLibrary(songs: [Track]){
        self.library = songs
    }
}
