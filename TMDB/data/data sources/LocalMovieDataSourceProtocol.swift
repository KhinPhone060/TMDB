//
//  CoreDataUpcomingDataSource.swift
//  TMDB
//
//  Created by iMyanmarHouse on 14/11/2024.
//

import Foundation
import CoreData

protocol LocalMovieDataSourceProtocol {
    func fetchUpcomingMovies() -> [UpcomingMovie]
    func saveUpcomingMovies(_ movies: [MovieEntity])
    func fetchPopularMovies() -> [PopularMovie]
    func savePopularMovies(_ movies: [MovieEntity])
}

class LocalMovieDataSource: LocalMovieDataSourceProtocol {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }
    
    func fetchUpcomingMovies() -> [UpcomingMovie] {
        let request: NSFetchRequest<UpcomingMovie> = UpcomingMovie.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching movies: \(error)")
            return []
        }
    }
    
    func fetchPopularMovies() -> [PopularMovie] {
        let request: NSFetchRequest<PopularMovie> = PopularMovie.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching movies: \(error)")
            return []
        }
    }
    
    func saveUpcomingMovies(_ movies: [MovieEntity]) {
        movies.forEach { movie in
            let entity = UpcomingMovie(context: context)
            entity.id = Int32(movie.id)
            entity.posterUrl = movie.posterPathUrl
            entity.isFavourite = false
        }
        do {
            try context.save()
        } catch {
            print("Error saving movies: \(error)")
        }
    }
    
    func savePopularMovies(_ movies: [MovieEntity]) {
        movies.forEach { movie in
            let entity = PopularMovie(context: context)
            entity.id = Int32(movie.id)
            entity.posterUrl = movie.posterPathUrl
            entity.isFavourite = false
        }
        do {
            try context.save()
        } catch {
            print("Error saving movies: \(error)")
        }
    }
}
