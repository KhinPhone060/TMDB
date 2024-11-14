//
//  MovieDependencyInjector.swift
//  TMDB
//
//  Created by iMyanmarHouse on 14/11/2024.
//

import Foundation

class MovieDependencyInjector {
    static func provideLocalMovieUsecase() -> LocalMovieUsecase {
        let context = PersistenceController.shared.container.viewContext
        let localDataSource = LocalMovieDataSource(context: context)
        let remoteRepository = GetMovieListRepository()
        let localRepository = LocalMovieRepository(localDataSource: localDataSource, remoteRepository: remoteRepository)
        return LocalMovieUsecase(repository: localRepository)
    }
}
