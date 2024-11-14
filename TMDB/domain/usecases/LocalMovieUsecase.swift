//
//  LocalMovieUsecase.swift
//  TMDB
//
//  Created by iMyanmarHouse on 14/11/2024.
//

import Foundation

class LocalMovieUsecase {
    private let repository: LocalMovieRepository
    
    init(repository: LocalMovieRepository) {
        self.repository = repository
    }
    
    func getUpcomingMovie() async -> [MovieEntity] {
        return await repository.getUpcomingMovies()
    }
    
    func getPopularMovie() async -> [MovieEntity] {
        return await repository.getPopularMovies()
    }
}
