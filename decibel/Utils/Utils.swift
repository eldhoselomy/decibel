//
//  Utils.swift
//  decibel
//
//  Created by Eldhose Lomy on 17/11/19.
//  Copyright © 2019 hacker.earth. All rights reserved.
//

import UIKit


class Utils{
    
    static func call(number: String){
        if let url = URL(string: "telprompt://\(number)".replacingOccurrences(of: " ", with: "")){
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
