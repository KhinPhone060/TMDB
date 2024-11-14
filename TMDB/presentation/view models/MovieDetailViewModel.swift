//
//  MovieDetailViewModel.swift
//  TMDB
//
//  Created by Khin Phone Ei on 13/11/2024.
//

import Foundation
import Combine

class MovieDetailViewModel: ObservableObject {
    @Published var movieDetail = MovieDetailEntity(model: MovieDetailModel(title: "", backdrop_path: "", poster_path: "", release_date: "", runtime: 0, genres: [], overview: ""))
    @Published var state: NetworkState = .loading
    @Published var favoriteMovieIds: [Int] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    private var getMovieDetailUsecase = GetMovieDetailUsecase(repository: GetMovieDetailRepository())
    private let localMovieUsecase: LocalMovieUsecase
    
    let movieId: Int
    
    init(movieId: Int) {
        self.localMovieUsecase = MovieDependencyInjector.provideLocalMovieUsecase()
        self.movieId = movieId
        getMovieDetail(movieId: movieId)
    }
    
    func getMovieDetail(movieId: Int) {
        state = .loading
        getMovieDetailUsecase.execute(movieId: movieId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.state = .error(error)
                }
            }, receiveValue: { [weak self] movieDetail in
                self?.movieDetail = movieDetail
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
        getMovieDetail(movieId: movieId)
    }
}
