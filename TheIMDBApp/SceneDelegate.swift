//
//  SceneDelegate.swift
//  TheIMDBApp
//
//  Created by Raúl Pavón on 29/07/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
    
        let navigationController = UINavigationController()
        let movieCoordinator = MovieCoordinator(navigationController: navigationController)
        movieCoordinator.start()
        
        navigationController.isNavigationBarHidden = true
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

