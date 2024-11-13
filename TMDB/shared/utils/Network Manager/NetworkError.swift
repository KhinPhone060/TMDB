//
//  NetworkError.swift
//  TMDB
//
//  Created by Khin Phone Ei on 13/11/2024.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case unprocessableContent
    case noInternetConnection
    case serverError(statusCode: Int)
    case decodingError
    case unknownError

    var errorDescription: String? {
        switch self {
        case .unprocessableContent:
            return "The request was well-formed but had semantic errors."
        case .noInternetConnection:
            return "No internet connection. Please check your network settings."
        case .serverError(let statusCode):
            return "Server returned an error with status code \(statusCode)."
        case .decodingError:
            return "Failed to decode the response data."
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}
