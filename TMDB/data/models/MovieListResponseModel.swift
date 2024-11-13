//
//  MovieListResponseModel.swift
//  TMDB
//
//  Created by Khin Phone Ei on 13/11/2024.
//

import Foundation

struct MovieListResponseModel: Codable {
    let page: Int
    let results: [MovieModel]
    let total_pages: Int
    let total_results: Int
}
