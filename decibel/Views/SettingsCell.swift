//
//  SettingsCell.swift
//  decibel
//
//  Created by Eldhose Lomy on 17/11/19.
//  Copyright © 2019 hacker.earth. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {

    @IBOutlet weak var settingsImageView: UIImageView!
    @IBOutlet weak var settingsNameLabel: UILabel!
    
    func configure(with data: MenuOption){
        settingsImageView.image = data.image
        settingsNameLabel.text = data.name
    }

}
