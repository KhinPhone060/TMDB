//
//  HomeScreenView.swift
//  TMDB
//
//  Created by Khin Phone Ei on 13/11/2024.
//

import SwiftUI
import Kingfisher

struct HomeScreenView: View {
    @StateObject var homeVm = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                switch homeVm.state {
                case .loading:
                    ProgressView()
                        .tint(.white)
                case .success:
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 40) {
                            MoviesList(title: "Upcoming Movies", movies: homeVm.upcomingMovies)
                            MoviesList(title: "Popular Movies", movies: homeVm.popularMovies)
                        }
                    }
                    .padding(.vertical)
                case .error(let error):
                    VStack {
                        Text("Error: \(error.localizedDescription)")
                        Button("Retry") {
                            homeVm.retry()
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.theme)
        }
    }
    
    func MoviesList(title: String, movies: [MovieEntity]) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(movies, id: \.uuid) { movie in
                        NavigationLink {
                            MovieDetailScreenView(id: movie.id)
                                .navigationBarHidden(true)
                        } label: {
                            MoviePosterImageView(id: movie.id, poster: movie.posterPathUrl, isFavorite: movie.isFavorite)
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    func MoviePosterImageView(id: Int, poster: String, isFavorite: Bool) -> some View {
        ZStack(alignment: .topTrailing) {
            KFImage(URL(string: poster))
                .resizable()
                .placeholder({ _ in
                    Image(.posterPlaceholder)
                        .resizable()
                        .scaledToFill()
                })
                .frame(width: 160, height: 240)
                .aspectRatio(contentMode: .fill)
                .cornerRadius(16)
            Button {
                homeVm.toggleFavorite(id: id, isFavorite: isFavorite)
            } label: {
                Image(systemName: isFavorite ? "heart.circle" : "heart.circle.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(.white)
                    .background(.gray)
                    .clipShape(Circle())
                    .padding(10)
                    .shadow(color: .blue.opacity(0.3), radius: 8, x: 0, y: 0)
            }
        }
    }
}

#Preview {
    HomeScreenView()
}
