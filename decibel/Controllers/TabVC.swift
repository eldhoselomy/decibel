//
//  TabVC.swift
//  decibel
//
//  Created by Eldhose Lomy on 17/11/19.
//  Copyright © 2019 hacker.earth. All rights reserved.
//

import UIKit

class TabVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup(){
        let titles = [Strings.LIBRARY, Strings.FAVORITES, Strings.PROFILE]
        for (index,tabBarItem) in (self.tabBar.items ?? []).enumerated(){
            tabBarItem.title = titles[index]
        }
    }
}
