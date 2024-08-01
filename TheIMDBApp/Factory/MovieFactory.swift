//
//  MovieFactory.swift
//  TheIMDBApp
//
//  Created by Raúl Pavón on 29/07/24.
//

import Foundation

protocol MovieFactory {
    func makeMovieListViewController(movieCoordinator: MovieCoordinator) -> MovieListViewController
    func makeMovieDeatailViewController(movieCoordinator: MovieCoordinator, movie: Movie, viewModel: MovieViewModel) -> MovieDetailViewController
    func makeMovieViewModel(view: MovieView, repository: MovieRepository) -> MovieViewModel
    func makeMovieRepository() -> MovieRepository
}

class MovieFactoryImp: MovieFactory {

    func makeMovieListViewController(movieCoordinator: MovieCoordinator) -> MovieListViewController {
        let movieListViewController = MovieListViewController(factory: self, movieCoordinator: movieCoordinator)
        return movieListViewController
    }
    
    func makeMovieDeatailViewController(movieCoordinator: MovieCoordinator, movie: Movie, viewModel: MovieViewModel) -> MovieDetailViewController {
        let movieDetailViewController = MovieDetailViewController(factory: self, movieCoordinator: movieCoordinator, movie: movie, viewModel: viewModel)
        return movieDetailViewController
    }
    
    func makeMovieViewModel(view: MovieView, repository: MovieRepository) -> MovieViewModel {
        let viewModel = MovieViewModelImp(view: view, movieRepository: repository)
        return viewModel
    }
    
    func makeMovieRepository() -> MovieRepository  {
        let repository = MovieRepository()
        return repository
    }
}
