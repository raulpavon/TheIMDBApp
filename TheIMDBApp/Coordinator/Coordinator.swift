//
//  Coordinator.swift
//  TheIMDBApp
//
//  Created by Raúl Pavón on 29/07/24.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

extension Coordinator {
    func presentOnTopViewController(viewController: UIViewController, animated: Bool) {
        if let presentedViewController = navigationController.presentedViewController {
            if let presentedNestedViewController = presentedViewController.presentedViewController {
                presentedNestedViewController.present(viewController, animated: animated)
            } else {
                presentedViewController.present(viewController, animated: animated)
            }
        } else {
            navigationController.present(viewController, animated: animated)
        }
    }
    
    func dismissOnTopViewController(animated: Bool, completion: (() -> Void)? = nil) {
        if let presentedViewController = navigationController.presentedViewController {
            if let presentedNestedViewController = presentedViewController.presentedViewController {
                presentedNestedViewController.dismiss(animated: animated, completion: completion)
            } else {
                presentedViewController.dismiss(animated: animated, completion: completion)
            }
        } else {
            navigationController.dismiss(animated: animated, completion: completion)
        }
    }
    
    func dismissEverythingOnTopViewController(animated: Bool, completion: (() -> Void)? = nil) {
        navigationController.dismiss(animated: animated, completion: completion)
    }
    
    func pushViewOnNavigationTop(viewController: UIViewController, animated: Bool) {
        if let presentedViewController = navigationController.presentedViewController {
            presentedViewController.navigationController?.pushViewController(viewController, animated: animated)
        } else {
            navigationController.pushViewController(viewController, animated: animated)
        }
    }
}
