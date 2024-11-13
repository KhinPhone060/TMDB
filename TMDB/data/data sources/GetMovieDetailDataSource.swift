//
//  GetMovieDetailDataSource.swift
//  TMDB
//
//  Created by Khin Phone Ei on 13/11/2024.
//

import Foundation

protocol GetMovieDetailDataSourceProtocol {
    func fetchMovieDetail(movieId: Int) async throws -> MovieDetailModel
}

class GetMovieDetailDataSource: GetMovieDetailDataSourceProtocol {
    private let networkUtils: NetworkUtilsProtocol
    
    init(networkUtils: NetworkUtilsProtocol = NetworkUtils.shared) {
        self.networkUtils = networkUtils
    }
    
    func fetchMovieDetail(movieId: Int) async throws -> MovieDetailModel {
        guard let url: URL = Constants.APIEndPoint.getMovieDetail(movieId: movieId).url else {
            throw URLError(.badURL)
        }
        return try await networkUtils.fetch(from: url)
    }
}
