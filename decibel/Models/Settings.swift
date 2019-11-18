//
//  Settings.swift
//  decibel
//
//  Created by Eldhose Lomy on 17/11/19.
//  Copyright © 2019 hacker.earth. All rights reserved.
//

import UIKit

enum MenuOption: String, CaseIterable{
    
    case profile        = ""
    case call           = "phone"
    case email          = "envelope"
    case resume         = "square.and.arrow.down"
    case portfolio      = "desktopcomputer"
    
    static var allCases: [MenuOption] {
        return [.profile, .call, .email, .resume, .portfolio]
    }
    
    var name: String{
        switch self {
        case .profile:
            return Strings.NAME
        case .call:
            return Strings.CALL
        case .email:
            return Strings.EMAIL
        case .resume:
            return Strings.RESUME
        case .portfolio:
            return Strings.PORTFOLIO
        }
    }
    
    var image: UIImage?{
        return UIImage(systemName: self.rawValue)
    }
}
