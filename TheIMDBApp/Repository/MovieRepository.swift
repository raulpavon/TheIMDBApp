//
//  MovieRepository.swift
//  TheIMDBApp
//
//  Created by Raúl Pavón on 29/07/24.
//

import Foundation
import UIKit

class MovieRepository {
    
    var isLoadingMore = false
    
    enum MovieError: Error {
        case networkError(Error)
        case decodingError(Error)
        case unknownError
    }
    
    func getTopMovies(page: Int, completionHandler: @escaping (Result<[Movie], MovieError>) -> Void) {
        
        guard !isLoadingMore else { return }
        
        isLoadingMore = true
        
        if let requestURL = URL(string: "\(GlobalConstants.TheMovieDatabase.theMovieDatabaseURL)?api_key=\(GlobalConstants.TheMovieDatabase.apiKey)&language=es-MX&page=\(page)") {
            var request = URLRequest(url: requestURL)
            request.httpMethod = GlobalConstants.TheMovieDatabase.httpMethod
            URLSession.shared.dataTask(with: request) { [weak self] (data, _, error) in
                guard let self = self else { return }
                self.isLoadingMore = false
                
                if let error = error {
                    print("Error fetching movies: \(error)")
                    completionHandler(.failure(.networkError(error)))
                    return
                }
                
                guard let data = data else {
                    completionHandler(.failure(.unknownError))
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(MovieList.self, from: data)
                    completionHandler(.success(response.results))
                } catch {
                    print("Error decoding movies: \(error)")
                    completionHandler(.failure(.decodingError(error)))
                }
            }.resume()
        } else {
            completionHandler(.failure(.unknownError))
        }
    }
    
    func getImageFromURL(imageString: String, completion: @escaping (UIImage?) -> Void) {
        guard let urlImage = URL(string: "\(GlobalConstants.TheMovieDatabase.posterImageURL)\(imageString)") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: urlImage) { data, response, error in
            if let error = error {
                print("Error fetching image: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            completion(image)
        }.resume()
    }
}
