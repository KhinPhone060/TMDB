//
//  GetMovieListDataSource.swift
//  TMDB
//
//  Created by Khin Phone Ei on 13/11/2024.
//

import Foundation

protocol GetMovieListDataSourceProtocol {
    func fetchMovieList(category: Constants.MovieCategory, page: Int) async throws -> MovieListResponseModel
}

class GetMovieListDataSource: GetMovieListDataSourceProtocol {
    private let networkUtils: NetworkUtilsProtocol
    
    init(networkUtils: NetworkUtilsProtocol = NetworkUtils.shared) {
        self.networkUtils = networkUtils
    }

    func fetchMovieList(category: Constants.MovieCategory, page: Int) async throws -> MovieListResponseModel {
        guard let url: URL = Constants.APIEndPoint.getMovieList(category: category, page: page).url else {
            throw URLError(.badURL)
        }
        return try await networkUtils.fetch(from: url)
    }
}

