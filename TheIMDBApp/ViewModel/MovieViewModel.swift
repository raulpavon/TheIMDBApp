//
//  MovieViewModel.swift
//  TheIMDBApp
//
//  Created by Raúl Pavón on 29/07/24.
//

import Foundation
import UIKit

class MovieViewModelImp: MovieViewModel {
    
    weak var view: MovieView?
    let movieRepository: MovieRepository
    private var movies = [Movie]()
    
    
    required init(view: MovieView?, movieRepository: MovieRepository) {
        self.view = view
        self.movieRepository = movieRepository
    }
    
    func getMovieList(page: Int) {
        movieRepository.getTopMovies(page: page) { [weak self] response in
            switch response {
            case .success(let movies):
                self?.movies += movies
                self?.view?.setMovie(movie: movies)
            case .failure(let error):
                print("Error fetching movies: \(error)")
            }
            
        }
    }
    
    func getMovieImage(imagePath: String, completion: @escaping (UIImage?) -> Void) {
        movieRepository.getImageFromURL(imageString: imagePath) { image in
            completion(image)
        }
    }
}
