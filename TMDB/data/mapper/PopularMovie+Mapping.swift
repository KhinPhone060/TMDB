//
//  PopularMovie+Mapping.swift
//  TMDB
//
//  Created by iMyanmarHouse on 14/11/2024.
//

import Foundation

extension PopularMovie {
    func toDomainModel() -> MovieEntity {
        return MovieEntity(
            movieResponse: MovieModel(
                id: Int(self.id),
                poster_path: self.posterUrl))
    }
}
