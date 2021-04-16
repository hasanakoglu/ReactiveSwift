//
//  AppDelegate.swift
//  ReactiveSwift
//
//  Created by Hasan Akoglu on 08/03/2021.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: MainCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navController = UINavigationController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        coordinator = MainCoordinator(navigationController: navController)
        coordinator?.start()
        
        return true
    }
}



