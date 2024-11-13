//
//  Constants.swift
//  TMDB
//
//  Created by Khin Phone Ei on 13/11/2024.
//

import Foundation

struct Constants {
    static let apiUrl: String = "https://api.themoviedb.org/3/"
    static let posterUrl: String = "https://image.tmdb.org/t/p/original"
    static let apiTimeoutInterval: Double = 15.0
    static let placeholderImage: String = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
    
    enum APIEndPoint {
        case getMovieList(category: MovieCategory, page: Int)
        case getMovieImage(posterPath: String)
        case getMovieDetail(movieId: Int)
        
        var url: URL? {
            switch self {
            case .getMovieList(let category, let page):
                return URL(string: "\(Constants.apiUrl)movie/\(category.rawValue)?language=en-US&page=\(page)")
            case .getMovieImage(let posterPath):
                return URL(string: "\(Constants.posterUrl)\(posterPath)")
            case .getMovieDetail(let movieId):
                return URL(string: "\(Constants.apiUrl)movie/\(movieId)?language=en-US")
            }
        }
    }
    
    enum MovieCategory: String {
        case popular
        case upcoming
    }
}
