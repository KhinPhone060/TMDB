//
//  MovieDetailModel.swift
//  TMDB
//
//  Created by Khin Phone Ei on 13/11/2024.
//

import Foundation

struct MovieDetailModel: Codable {
    let title: String?
    let backdrop_path: String?
    let poster_path: String?
    let release_date: String?
    let runtime: Int
    let genres: [Genre]
    let overview: String?
}
