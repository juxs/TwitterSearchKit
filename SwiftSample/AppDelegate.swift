//
//  AppDelegate.swift
//  SwiftSample
//
//  Created by Julian Gruber on 13/07/2017.
//  Copyright © 2017 Julian Gruber. All rights reserved.
//

import UIKit
import TwitterSearchKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Set Twitter credentials
        TwitterSearchKit.tokenCredentials = "R0l4N1ZoZ1J0Z1YzTjk5Z2VPOHVNZzFzNTpJR2lEUXhubmpXMExSNkVMSVVqNEo4T0VwSTZRbG12ZGJNWE9QVGNNS0Y5aDNBR3dIRA=="
        
        let vc = ViewController()
        let nav = UINavigationController(rootViewController: vc)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = nav
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
        
        return true
    }


}

