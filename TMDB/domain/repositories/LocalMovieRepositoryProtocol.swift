//
//  LocalMovieRepositoryProtocol.swift
//  TMDB
//
//  Created by iMyanmarHouse on 14/11/2024.
//

import Foundation

protocol LocalMovieRepositoryProtocol {
    func getUpcomingMovies() async -> [MovieEntity]
    func saveUpcomingMovies(_ movies: [MovieEntity])
    
    func getPopularMovies() async -> [MovieEntity]
    func savePopularMovies(_ movies: [MovieEntity])
}

