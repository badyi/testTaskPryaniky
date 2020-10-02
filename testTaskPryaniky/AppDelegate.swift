//
//  AppDelegate.swift
//  testTaskPryaniky
//
//  Created by и on 28.09.2020.
//  Copyright © 2020 badyi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navControl = UINavigationController()
        let vc = ModuleBuilder.createMain()
        navControl.viewControllers = [vc]
        
        self.window?.rootViewController = navControl
        self.window?.makeKeyAndVisible()

        return true
    }

}

