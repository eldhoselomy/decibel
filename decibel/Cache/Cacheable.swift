//
//  Cacheable.swift
//  decibel
//
//  Created by Eldhose Lomy on 17/11/19.
//  Copyright © 2019 hacker.earth. All rights reserved.
//

import UIKit

protocol Cacheable{
    func getImageFromCache(key: String)->UIImage?
    func saveImageToCache(key: String, image: UIImage)
}
