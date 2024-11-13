//
//  MovieDetailEntity.swift
//  TMDB
//
//  Created by Khin Phone Ei on 13/11/2024.
//

import Foundation

struct MovieDetailEntity {
    let title: String
    let backdropPath: String
    let posterPath: String
    let releaseDate: String
    let runtime: Int
    let genre: String
    let overview: String
    
    init(model: MovieDetailModel) {
        self.title = model.title ?? "No title found"
        self.backdropPath = model.backdrop_path != nil ? Constants.APIEndPoint.getMovieImage(posterPath: model.backdrop_path ?? "").url?.absoluteString ?? "" : Constants.placeholderImage
        self.posterPath = model.poster_path != nil ? Constants.APIEndPoint.getMovieImage(posterPath: model.poster_path ?? "").url?.absoluteString ?? "" : Constants.placeholderImage
        self.releaseDate = model.release_date ?? "No release date"
        self.runtime = model.runtime
        self.genre = model.genres.first?.name ?? "No genre"
        self.overview = model.overview ?? "No overview"
    }
}
