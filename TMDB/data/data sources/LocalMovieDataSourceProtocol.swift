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
    
    func fetchFavoriteMovieIds() -> [Int]
    func saveFavoriteMovie(_ movieIds: Int)
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
        }
        do {
            try context.save()
        } catch {
            print("Error saving movies: \(error)")
        }
    }
    
    func fetchFavoriteMovieIds() -> [Int] {
        let request: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        do {
            let ids = try context.fetch(request).compactMap { movie in
                Int(movie.id)
            }
            return ids
        } catch {
            print("Error fetching movies: \(error)")
            return []
        }
    }
    
    func saveFavoriteMovie(_ movieId: Int) {
        let entity = FavoriteMovie(context: context)
        entity.id = Int32(movieId)
        
        do {
            try context.save()
        } catch {
            print("Error saving movies: \(error)")
        }
    }
    
    func deleteFavoriteMovie(_ movieId: Int) {
        let request: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", movieId)
        
        do {
            if let movieEntity = try context.fetch(request).first {
                context.delete(movieEntity)
                try context.save()
            }
        } catch {
            print("Error deleting favorite movie: \(error)")
        }
    }
}
