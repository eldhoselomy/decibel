//
//  Cache.swift
//  decibel
//
//  Created by Eldhose Lomy on 17/11/19.
//  Copyright © 2019 hacker.earth. All rights reserved.
//

import UIKit

class ImageCache: Cacheable{
    
    static let shared: Cacheable = ImageCache()
    private init() { }
    
    private let imageCache = MemoryCache.init()
    private let storageCache = DiskCache.init()
    
    func getImageFromCache(key: String) -> UIImage? {
        if let image = imageCache.getImageFromCache(key: key){
            return image
        }else if let image = storageCache.getImageFromCache(key: key){
            imageCache.saveImageToCache(key: key, image: image)
            return image
        }
        return nil
    }
    
    func saveImageToCache(key: String, image: UIImage) {
        imageCache.saveImageToCache(key: key, image: image)
        storageCache.saveImageToCache(key: key, image: image)
    }
    
}
