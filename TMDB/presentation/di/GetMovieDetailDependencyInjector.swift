//
//  GetMovieDetailDependencyInjector.swift
//  TMDB
//
//  Created by iMyanmarHouse on 14/11/2024.
//

import Foundation

struct GetMovieDetailDependencyInjector {
    static func provideMovieDetailUsecase() -> GetMovieDetailUsecase {
        let dataSource = GetMovieDetailDataSource()
        let repository = GetMovieDetailRepository(getMovieDetailDataSource: dataSource)
        return GetMovieDetailUsecase(repository: repository)
    }
}
