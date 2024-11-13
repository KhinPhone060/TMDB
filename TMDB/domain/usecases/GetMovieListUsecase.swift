//
//  GetMovieListUsecase.swift
//  TMDB
//
//  Created by Khin Phone Ei on 13/11/2024.
//

import Foundation
import Combine

class GetMovieListUsecase {
    private let repository: GetMovieListRepositoryProtocol
    
    init(repository: GetMovieListRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(category: Constants.MovieCategory) -> AnyPublisher<[MovieEntity], Error> {
        return Future<[MovieEntity], Error> { promise in
            Task {
                do {
                    let response = try await self.repository.fetchMovieList(category: category, page: 1)
                    promise(.success(response))
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
