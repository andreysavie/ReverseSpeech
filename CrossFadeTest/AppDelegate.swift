//
//  AppDelegate.swift
//  CrossFadeTest
//
//  Created by Андрей Рыбалкин on 19.06.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = MusicViewController()
        window?.makeKeyAndVisible()

        return true
    }

}

