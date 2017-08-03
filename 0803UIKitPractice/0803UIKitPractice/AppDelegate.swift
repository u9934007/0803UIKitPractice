//
//  AppDelegate.swift
//  0803UIKitPractice
//
//  Created by 楊采庭 on 2017/8/3.
//  Copyright © 2017年 楊采庭. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        window = UIWindow(frame: UIScreen.main.bounds)
//        let homeViewController = ViewController()
//        let homeViewController = WKWebViewController()

        let navigationController = UINavigationController(rootViewController: ViewController())
        self.window!.rootViewController = navigationController
        window!.makeKeyAndVisible()

        return true

    }
}
