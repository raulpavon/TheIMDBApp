//
//  MovieCoordinator.swift
//  TheIMDBApp
//
//  Created by Raúl Pavón on 29/07/24.
//

import Foundation
import UIKit

class MovieCoordinator {
    var navigationController: UINavigationController
    private let factory =  MovieFactoryImp()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let movieListViewController = factory.makeMovieListViewController(movieCoordinator: self)
        navigationController.setViewControllers([movieListViewController], animated: false)
    }
    
    func openMovieDetail(movie: Movie, viewModel: MovieViewModel) {
        let movieDetailViewController = factory.makeMovieDeatailViewController(movieCoordinator: self, movie: movie, viewModel: viewModel)
        navigationController.pushViewController(movieDetailViewController, animated: true)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
}
