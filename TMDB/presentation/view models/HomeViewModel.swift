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
    
    private var cancellables = Set<AnyCancellable>()
    
    private let getMovieListUsecase: GetMovieListUsecase
    
    init() {
        self.getMovieListUsecase = GetMovieListUsecase(repository: GetMovieListRepository())
        fetchUpcomingMovieList()
        fetchPopularMovieList()
    }
    
    func fetchUpcomingMovieList() {
        getMovieListUsecase.execute(category: .upcoming)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.upcomingMovies = response
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
}
