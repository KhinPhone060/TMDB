//
//  GetMovieDetailRepositoryProtocol.swift
//  TMDB
//
//  Created by Khin Phone Ei on 13/11/2024.
//

import Foundation

protocol GetMovieDetailRepositoryProtocol {
    func fetchMovieDetail(movieId: Int) async throws -> MovieDetailEntity
}
