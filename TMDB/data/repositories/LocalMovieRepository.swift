//
//  LocalMovieRepository.swift
//  TMDB
//
//  Created by iMyanmarHouse on 14/11/2024.
//

import Foundation
import CoreData

class LocalMovieRepository: LocalMovieRepositoryProtocol {
    private let localDataSource: LocalMovieDataSource
    private let remoteRepository: GetMovieListRepository
    
    init(localDataSource: LocalMovieDataSource, remoteRepository: GetMovieListRepository) {
        self.localDataSource = localDataSource
        self.remoteRepository = remoteRepository
    }
    
    func getUpcomingMovies() async -> [MovieEntity] {
        let localMovies = localDataSource.fetchUpcomingMovies()
        if !localMovies.isEmpty {
            return localMovies.map { $0.toDomainModel() }
        }
        
        do {
            let remoteMovies = try await remoteRepository.fetchMovieList(category: .upcoming, page: 1)
            saveUpcomingMovies(remoteMovies)
            return localMovies.map { $0.toDomainModel() }
        } catch {
            print("Failed to fetch from API: \(error)")
            return []
        }
    }
    
    func getPopularMovies() async -> [MovieEntity] {
        let localMovies = localDataSource.fetchPopularMovies()
        if !localMovies.isEmpty {
            return localMovies.map { $0.toDomainModel() }
        }
        
        do {
            let remoteMovies = try await remoteRepository.fetchMovieList(category: .popular, page: 1)
            savePopularMovies(remoteMovies)
            return localMovies.map { $0.toDomainModel() }
        } catch {
            print("Failed to fetch from API: \(error)")
            return []
        }
    }
    
    func saveUpcomingMovies(_ movies: [MovieEntity]) {
        localDataSource.saveUpcomingMovies(movies)
    }
    
    func savePopularMovies(_ movies: [MovieEntity]) {
        localDataSource.savePopularMovies(movies)
    }
    
    func updateFavoriteStatus(for movieId: Int, isFavorite: Bool) {
        localDataSource.updateFavoriteStatus(for: movieId, isFavorite: isFavorite)
    }
}
