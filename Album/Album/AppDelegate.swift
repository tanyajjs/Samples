//
//  AppDelegate.swift
//  Album
//
//  Created by Danya on 9/14/20.
//  Copyright © 2020 Danya. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: AlbumsViewController())
        window?.makeKeyAndVisible()

        return true
    }

}

