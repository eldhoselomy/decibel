//
//  RemoteCommanadManager.swift
//  decibel
//
//  Created by Eldhose Lomy on 17/11/19.
//  Copyright © 2019 hacker.earth. All rights reserved.
//

import Foundation
import MediaPlayer

class RemoteCommanadManager{
    
    static let shared = RemoteCommanadManager()
    private let commandCenter = MPRemoteCommandCenter.shared()
    
    private init() {
        addObserverForPlay()
        addObserverForPause()
        addObserverForNext()
        addObserverForPrevious()
    }
    
    func addObserverForPlay(){
        commandCenter.playCommand.addTarget { event in
            if !AudioManager.shared.isPlaying() {
                AudioManager.shared.play()
                return .success
            }
            return .commandFailed
        }
    }
    
    func addObserverForPause(){
        commandCenter.pauseCommand.addTarget { event in
            if AudioManager.shared.isPlaying() {
                AudioManager.shared.pause()
                return .success
            }
            return .commandFailed
        }
    }
    
    func addObserverForNext(){
        commandCenter.nextTrackCommand.addTarget { event in
            AudioManager.shared.next()
            return .success
        }
    }
    
    func addObserverForPrevious(){
        commandCenter.previousTrackCommand.addTarget { event in
            AudioManager.shared.previous()
            return .success
        }
    }
    
    func setupNowPlaying() {
        guard let song = AudioManager.shared.currentSong() else{
            return
        }
        var nowPlayingInfo = [String : Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = song.song
        nowPlayingInfo[MPMediaItemPropertyArtist] = song.artists
        let image = ImageCache.shared.getImageFromCache(key: (song.image as NSString).lastPathComponent) ?? Constants.artworkPlaceholder
        nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { size in
            return image
        }
        //nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player.currentTime
        //nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = audioPlayer.duration
        //nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player.rate

        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
}
