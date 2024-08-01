//
//  AppDelegate.swift
//  TheIMDBApp
//
//  Created by Raúl Pavón on 29/07/24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var movieCoordinator: MovieCoordinator?
    let navController = UINavigationController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initializeWindow()
        return true
    }

    func initializeWindow() {
        movieCoordinator = MovieCoordinator(navigationController: navController)
        movieCoordinator?.start()
        navController.isNavigationBarHidden = true
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}
