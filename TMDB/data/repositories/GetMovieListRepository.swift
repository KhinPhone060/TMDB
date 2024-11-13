//
//  GetMovieListRepository.swift
//  TMDB
//
//  Created by Khin Phone Ei on 13/11/2024.
//

import Foundation

class GetMovieListRepository: GetMovieListRepositoryProtocol {
    private let getMovieListDataSource: GetMovieListDataSourceProtocol
    
    init(getMovieListDataSource: GetMovieListDataSourceProtocol = GetMovieListDataSource()) {
        self.getMovieListDataSource = getMovieListDataSource
    }
    
    func fetchMovieList(category: Constants.MovieCategory, page: Int) async throws -> [MovieEntity] {
        let movies: MovieListResponseModel = try await getMovieListDataSource.fetchMovieList(category: category, page: page)
        let movieEntities: [MovieEntity] = movies.results.compactMap { movie in
            return MovieEntity(movieResponse: movie)
        }
        return movieEntities
    }
}
