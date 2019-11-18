//
//  PaymentVC.swift
//  decibel
//
//  Created by Eldhose Lomy on 17/11/19.
//  Copyright © 2019 hacker.earth. All rights reserved.
//

import UIKit

class PaymentVC: BaseVC {

    @IBOutlet weak var downloadButton: UIButton!
   
    override func setup() {
        super.setup()
        self.title = "Payment"
    }

    @IBAction func download(_ sender: UIButton){
        downloadButton.isEnabled = false
        downloadButton.setTitle("Downloaded", for: .normal)
    }
}
