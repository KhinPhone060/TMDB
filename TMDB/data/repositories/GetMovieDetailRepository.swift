//
//  GetMovieDetailRepository.swift
//  TMDB
//
//  Created by Khin Phone Ei on 13/11/2024.
//

import Foundation

class GetMovieDetailRepository: GetMovieDetailRepositoryProtocol {
    private let getMovieDetailDataSource: GetMovieDetailDataSourceProtocol
    
    init(getMovieDetailDataSource: GetMovieDetailDataSourceProtocol = GetMovieDetailDataSource()) {
        self.getMovieDetailDataSource = getMovieDetailDataSource
    }
    
    func fetchMovieDetail(movieId: Int) async throws -> MovieDetailEntity {
        let movieDetail = try await getMovieDetailDataSource.fetchMovieDetail(movieId: movieId)
        let movieDetailModel = MovieDetailModel(title: movieDetail.title, backdrop_path: movieDetail.backdrop_path, poster_path: movieDetail.poster_path, release_date: movieDetail.release_date, runtime: movieDetail.runtime, genres: movieDetail.genres, overview: movieDetail.overview)
        let movieDetailEntity: MovieDetailEntity = MovieDetailEntity(model: movieDetailModel)
        return movieDetailEntity
    }
}
