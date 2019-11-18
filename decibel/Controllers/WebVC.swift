//
//  WebVC.swift
//  decibel
//
//  Created by Eldhose Lomy on 17/11/19.
//  Copyright © 2019 hacker.earth. All rights reserved.
//

import UIKit
import WebKit

class WebVC: BaseVC {

    @IBOutlet weak var webview: WKWebView!
    
    override func setup() {
        super.setup()
        self.title = Strings.RESUME
        guard let url = Bundle.main.url(forResource: "Resume", withExtension: ".pdf") else{
            return
        }
        webview.load(URLRequest.init(url: url))
    }
}
