//
//  NetworkUtilsProtocol.swift
//  TMDB
//
//  Created by Khin Phone Ei on 13/11/2024.
//

import Foundation

protocol NetworkUtilsProtocol {
    func fetch<T: Codable>(from url: URL) async throws -> T
}
