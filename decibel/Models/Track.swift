//
//  Track.swift
//  decibel
//
//  Created by Eldhose Lomy on 17/11/19.
//  Copyright © 2019 hacker.earth. All rights reserved.
//

import Foundation

class Track: Codable{
    let song: String
    let url: String
    let artists: String
    let image: String
    var isFavorite: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case song
        case url
        case artists
        case image = "cover_image"
    }
    
    func favorite(enable: Bool){
        self.isFavorite = enable
    }

}
