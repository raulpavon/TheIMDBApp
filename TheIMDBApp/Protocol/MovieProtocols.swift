//
//  MovieProtocols.swift
//  TheIMDBApp
//
//  Created by Raúl Pavón on 29/07/24.
//

import Foundation
import UIKit

protocol MovieView: AnyObject {
    func setMovie(movie: [Movie])
    func goToMovieDetail(movie: Movie)
}

protocol MovieViewModel {
    func getMovieList(page: Int)
    func getMovieImage(imagePath: String, completion: @escaping (UIImage?) -> Void)
}
