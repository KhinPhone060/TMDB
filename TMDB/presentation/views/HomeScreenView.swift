//
//  HomeScreenView.swift
//  TMDB
//
//  Created by Khin Phone Ei on 13/11/2024.
//

import SwiftUI

struct HomeScreenView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 40) {
                UpcomingMoviesList()
                UpcomingMoviesList()
            }
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.theme)
    }
    
    @ViewBuilder
    func UpcomingMoviesList() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Upcoming Movies")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(0..<8) { i in
                        MoviePosterImageView()
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    func MoviePosterImageView() -> some View {
        ZStack(alignment: .topTrailing) {
            Image(.demo)
                .resizable()
                .frame(width: 160, height: 240)
                .aspectRatio(contentMode: .fill)
                .cornerRadius(16)
            Image(systemName: "heart.circle.fill")
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

#Preview {
    HomeScreenView()
}
