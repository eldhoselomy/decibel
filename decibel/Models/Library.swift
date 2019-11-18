//
//  Library.swift
//  decibel
//
//  Created by Eldhose Lomy on 17/11/19.
//  Copyright © 2019 hacker.earth. All rights reserved.
//

import Foundation

class Library: Codable{
    let songs: [Track]

    required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.songs  = try container.decode([Track].self)
    }
}
