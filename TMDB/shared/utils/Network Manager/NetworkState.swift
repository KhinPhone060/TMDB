//
//  NetworkState.swift
//  TMDB
//
//  Created by Khin Phone Ei on 13/11/2024.
//

import Foundation

enum NetworkState {
    case loading
    case success
    case error(Error)
}
