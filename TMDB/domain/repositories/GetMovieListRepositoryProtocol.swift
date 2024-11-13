//
//  GetMovieListRepositoryProtocol.swift
//  TMDB
//
//  Created by Khin Phone Ei on 13/11/2024.
//

import Foundation

protocol GetMovieListRepositoryProtocol {
    func fetchMovieList(category: Constants.MovieCategory, page: Int) async throws -> [MovieEntity]
}
