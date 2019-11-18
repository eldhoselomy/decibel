//
//  Extensions.swift
//  decibel
//
//  Created by Eldhose Lomy on 17/11/19.
//  Copyright © 2019 hacker.earth. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer

extension UIViewController{
    /**
     This variable can be used for get storyboard identifier of a viewcontroller from storyboard
     ## Important Notes ##
     Set the `storyboardIdentifier` in storyboard as same as class name
     */
    static var storyboardID:String {
        return String(describing: self)
    }
}

extension UIView{
    /**
     This variable can be used for get nib name of a view
     ## Important Notes ##
     Set the file name same as the class name
     */
    static var nibName:String {
        return String(describing: self)
    }
}

extension UITableViewCell{
    /**
     This variable can be used for get reusable identifier of tableview cell from storyboard
     ## Important Notes ##
     Set the `resuableIdentifier` in storyboard as same as class name
     */
    static var cellIdentifier:String {
        return String(describing: self)
    }
}


extension AVPlayer {
    /**
     This variable can be used to identify the state of AVPlayer
     */
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}


extension AVQueuePlayer {

    func advanceToPreviousItem(for currentItem: Int, with initialItems: [AVPlayerItem]) {
        self.removeAllItems()
        for i in currentItem..<initialItems.count {
            let playerItem = i > 0 ? initialItems[i-1] : initialItems[0]
            if self.canInsert(playerItem, after: nil) {
                playerItem.seek(to: CMTime.zero, completionHandler: nil)
                self.insert(playerItem, after: nil)
            }
        }
    }
}

extension MPVolumeView {
  static func setVolume(_ volume: Float) {
    let volumeView = MPVolumeView()
    let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
      slider?.value = volume
    }
  }
}
