//
//  GetMovieDetailUsecase.swift
//  TMDB
//
//  Created by Khin Phone Ei on 13/11/2024.
//

import Foundation
import Combine

class GetMovieDetailUsecase {
    private let repository: GetMovieDetailRepositoryProtocol
    
    init(repository: GetMovieDetailRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(movieId: Int) -> AnyPublisher <MovieDetailEntity, Error> {
        return Future<MovieDetailEntity, Error> { promise in
            Task {
                do {
                    let movieDetail = try await self.repository.fetchMovieDetail(movieId: movieId)
                    promise(.success(movieDetail))
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
