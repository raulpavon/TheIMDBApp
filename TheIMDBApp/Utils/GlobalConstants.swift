//
//  GlobalConstants.swift
//  TheIMDBApp
//
//  Created by Raúl Pavón on 29/07/24.
//

import Foundation

struct GlobalConstants {
    enum TheMovieDatabase {
        static let theMovieDatabaseURL = "https://api.themoviedb.org/3/movie/top_rated"
        static let apiKey = "0d7994a757b0db5b35b543bce7921a3a"
        static let httpMethod = "GET"
        static let posterImageURL = "https://image.tmdb.org/t/p/w185"
    }
    
    enum Font {
        static let robotoRegular = "Roboto-Regular"
        static let robotoLight = "Roboto-Light"
        static let robotoBold = "Roboto-Bold"
        static let robotoThin = "Roboto-Thin"
        static let robotoMedium = "Roboto-Medium"
        static let robotoBlack = "Roboto-Black"
    }
    
    enum Color {
        static let green = "Green"
        static let gray = "Gray"
        static let aquaGreen = "AquaGreen"
        static let greenGray = "GreenGray"
        static let lightGray = "LightGray"
        static let lightGreen = "LightGreen"
    }
    
    enum Image {
        static let logo = "Logo"
    }
}
