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
    
    @Published var state: NetworkState = .loading
    
    private var cancellables = Set<AnyCancellable>()
    
    private let getMovieListUsecase: GetMovieListUsecase
    
    init() {
        self.getMovieListUsecase = GetMovieListUsecase(repository: GetMovieListRepository())
        fetchUpcomingMovieList()
        fetchPopularMovieList()
    }
    
    func fetchUpcomingMovieList() {
        state = .loading
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
        getMovieListUsecase.execute(category: .popular)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.popularMovies = response
            })
            .store(in: &cancellables)
    }
    
    func retry() {
        fetchUpcomingMovieList()
        fetchPopularMovieList()
    }
}
