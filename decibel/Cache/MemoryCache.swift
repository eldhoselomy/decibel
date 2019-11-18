//
//  MemoryCache.swift
//  decibel
//
//  Created by Eldhose Lomy on 17/11/19.
//  Copyright © 2019 hacker.earth. All rights reserved.
//

import UIKit

class MemoryCache: Cacheable{
    
    private let cache = NSCache<NSString, UIImage>()
    
    func getImageFromCache(key: String)->UIImage?{
        return cache.object(forKey: key as NSString)
    }
    
    func saveImageToCache(key: String, image: UIImage){
        cache.setObject(image, forKey: key as NSString)
    }
}
