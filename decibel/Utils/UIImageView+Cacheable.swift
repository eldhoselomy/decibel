//
//  UIImageView+Cacheable.swift
//  decibel
//
//  Created by Eldhose Lomy on 17/11/19.
//  Copyright © 2019 hacker.earth. All rights reserved.
//

import UIKit


extension UIImageView{
    
    enum Animation {
        case crossDissolve
        case none
    }
    
    func setRemoteImage(url: URL?, placeholder: UIImage? = nil, animation: Animation = .crossDissolve){
        self.image = placeholder
        if let imageFromCache = ImageCache.shared.getImageFromCache(key: url?.lastPathComponent ?? ""){
            self.animate(image: imageFromCache, animation: .none)
            return
        }
        DispatchQueue.global().async {
            let data = try? url
                .flatMap { try Data(contentsOf: $0) }
                .flatMap { UIImage(data: $0) }
            guard let image = data else{
                return
            }
            ImageCache.shared.saveImageToCache(key: url?.lastPathComponent ?? "", image: image)
            DispatchQueue.main.async { [weak self] in
                self?.animate(image: image, animation: animation)
            }
        }
    }
    
    private func animate(image: UIImage?, animation: Animation){
        guard let downloadedImage = image else {
            return
        }
        self.image = nil
        switch animation {
        case .crossDissolve:
            UIView.transition(with: self,
                              duration: 1, options: .transitionCrossDissolve, animations: { [weak self] in
                                self?.image = downloadedImage
            }, completion: nil)
        default:
            self.image = downloadedImage
        }
    }
}


