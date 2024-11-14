//
//  MovieDetailScreenView.swift
//  TMDB
//
//  Created by Khin Phone Ei on 13/11/2024.
//

import SwiftUI
import Kingfisher

struct MovieDetailScreenView: View {
    @StateObject var movieDetailVm: MovieDetailViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    let id: Int
    
    init(id: Int) {
        self.id = id
        self._movieDetailVm = StateObject(wrappedValue: MovieDetailViewModel(movieId: id))
    }
    
    var body: some View {
        ZStack {
            switch movieDetailVm.state {
            case .loading:
                ProgressView()
                    .tint(.white)
            case .success:
                ScrollView(showsIndicators: false) {
                    VStack {
                        TopBar()
                        
                        ZStack(alignment: .bottom) {
                            VStack {
                                BackDropPosterView()
                                Spacer().frame(height: 70)
                            }
                                
                            MoviePosterAndTitle()
                        }
                        
                        MovieInfoSection()
                        
                        AboutMovieSection()
                        
                        Spacer()
                    }
                }
            case .error(let error):
                VStack {
                    Text("Error: \(error.localizedDescription)")
                    Button("Retry") {
                        movieDetailVm.retry()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.theme)
    }
    
    func TopBar() -> some View {
        HStack {
            Image(.arrowLeft)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            Spacer()
            Text("Detail")
                .font(.callout)
                .fontWeight(.semibold)
            Spacer()
            Image(.bookmarkIc)
        }
        .padding()
        .foregroundColor(.white)
    }
    
    func BackDropPosterView() -> some View {
        KFImage(URL(string: movieDetailVm.movieDetail.backdropPath))
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.848)
    }
    
    func MoviePosterAndTitle() -> some View {
        VStack {
            HStack(alignment: .bottom) {
                KFImage(URL(string: movieDetailVm.movieDetail.posterPath))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                    .cornerRadius(16)
                Text(movieDetailVm.movieDetail.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.horizontal, 30)
        }
    }
    
    func MovieInfoSection() -> some View {
        VStack(spacing: 20) {
            HStack {
                Image("calendar")
                    .renderingMode(.template)
                Text(movieDetailVm.movieDetail.releaseDate)
                    .fontWeight(.medium)
                
                Divider()
                    .background(.white)
                
                Image("clock")
                Text("\(movieDetailVm.movieDetail.runtime) Minutes")
                    .fontWeight(.medium)
                
                Divider()
                    .background(.white)
                
                Image("ticket")
                Text(movieDetailVm.movieDetail.genre)
                    .fontWeight(.medium)
            }
            .foregroundColor(.gray)
            .font(.caption)
            .frame(height: 20)
        }
    }
    
    func AboutMovieSection() -> some View {
        Text(movieDetailVm.movieDetail.overview)
            .foregroundColor(.white)
            .padding()
    }
}

#Preview {
    MovieDetailScreenView(id: 1084736)
}
