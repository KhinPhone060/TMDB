//
//  HomeViewModel.swift
//  TMDB
//
//  Created by Khin Phone Ei on 13/11/2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var upcomingMovies: [MovieEntity] = []
    @Published var popularMovies: [MovieEntity] = []
    @Published var favoriteMovieIds: [Int] = []
    
    @Published var state: NetworkState = .loading
    
    private var cancellables = Set<AnyCancellable>()
    
    private let getMovieListUsecase: GetMovieListUsecase
    private let localMovieUsecase: LocalMovieUsecase
    
    init() {
        self.getMovieListUsecase = GetMovieListDependencyInjector.provideMovieListUsecase()
        self.localMovieUsecase = MovieDependencyInjector.provideLocalMovieUsecase()
        fetchUpcomingMovieList()
        fetchPopularMovieList()
    }
    
    func fetchUpcomingMovieList() {
        state = .loading
        
        Task {
            let offlineMovies = await localMovieUsecase.getUpcomingMovie()
            DispatchQueue.main.async {
                self.upcomingMovies = offlineMovies
            }
        }
        
        getMovieListUsecase.execute(category: .upcoming)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .error(error)
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.upcomingMovies = response
                self?.state = .success
            })
            .store(in: &cancellables)
    }
    
    func fetchPopularMovieList() {
        state = .loading
        
        Task {
            let offlineMovies = await localMovieUsecase.getPopularMovie()
            DispatchQueue.main.async {
                self.upcomingMovies = offlineMovies
            }
        }
        
        getMovieListUsecase.execute(category: .popular)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .error(error)
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.popularMovies = response
                self?.state = .success
            })
            .store(in: &cancellables)
    }
    
    func loadFavoriteMovies() {
        favoriteMovieIds = localMovieUsecase.fetchFavoriteMovieIds()
    }
    
    func toggleFavoriteStatus(for movieId: Int) {
        if favoriteMovieIds.contains(movieId) {
            localMovieUsecase.removeFavoriteMovie(movieId)
            favoriteMovieIds.removeAll { $0 == movieId }
        } else {
            localMovieUsecase.addFavoriteMovie(movieId)
            favoriteMovieIds.append(movieId)
        }
    }
    
    func retry() {
        fetchUpcomingMovieList()
        fetchPopularMovieList()
    }
}
