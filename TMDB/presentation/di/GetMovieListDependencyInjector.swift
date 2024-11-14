//
//  GetMovieListDependencyInjector.swift
//  TMDB
//
//  Created by iMyanmarHouse on 14/11/2024.
//

import Foundation

struct GetMovieListDependencyInjector {
    static func provideMovieListUsecase() -> GetMovieListUsecase {
        let dataSource = GetMovieListDataSource()
        let repository = GetMovieListRepository(getMovieListDataSource: dataSource)
        return GetMovieListUsecase(repository: repository)
    }
}
