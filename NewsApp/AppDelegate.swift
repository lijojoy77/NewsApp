//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Lijo Joy on 12/09/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let rootViewController = VCHome()
           // Embed the root view controller in a navigation controller
           let navigationController = UINavigationController(rootViewController: rootViewController)
           // Create the UIWindow
           let window = UIWindow(frame: UIScreen.main.bounds)
           window.rootViewController = navigationController
           window.makeKeyAndVisible()

           // Assign the window to the application's window
           self.window = window
        return true
    }


}

