//
//  WKWebViewController.swift
//  0803UIKitPractice
//
//  Created by 楊采庭 on 2017/8/3.
//  Copyright © 2017年 楊采庭. All rights reserved.
//

import UIKit
import WebKit

class WKWebViewController: UIViewController {

    var websiteURL: String?
    var wKWebView: WKWebView!
    let fullScreenSize = UIScreen.main.bounds.size

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "瀏覽器"
        view.backgroundColor = UIColor.white

        wKWebView = WKWebView(frame: CGRect(
            x: 30, y: 80,
            width: fullScreenSize.width - 60,
            height: fullScreenSize.height - 160))
        wKWebView.load(URLRequest(url: URL(string: websiteURL!)!))
        wKWebView.layer.borderColor = UIColor.skyBlue.cgColor
        wKWebView.layer.borderWidth = 1

        self.view.addSubview(self.wKWebView)

    }
}
