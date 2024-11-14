//
//  MovieEntities.swift
//  TMDB
//
//  Created by Khin Phone Ei on 13/11/2024.
//

import Foundation

struct MovieEntity: Hashable {
    let uuid = UUID()
    let id: Int
    var posterPathUrl: String
    
    init(movieResponse: MovieModel) {
        self.id = movieResponse.id
        self.posterPathUrl = movieResponse.poster_path != nil ?
        Constants.APIEndPoint.getMovieImage(posterPath: movieResponse.poster_path ?? "").url?.absoluteString ?? "" : Constants.placeholderImage
    }
}
