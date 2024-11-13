//
//  NetworkUtils.swift
//  TMDB
//
//  Created by Khin Phone Ei on 13/11/2024.
//

import Foundation
import Alamofire

class NetworkUtils: NetworkUtilsProtocol {
    static let shared = NetworkUtils()
    private let session: Session
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = Constants.apiTimeoutInterval
        configuration.timeoutIntervalForResource = Constants.apiTimeoutInterval
        self.session = Session(configuration: configuration, interceptor: NetworkInterceptor())
    }
    
    func fetch<T: Codable>(from url: URL) async throws -> T {
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        let data: Data = try await withCheckedThrowingContinuation { continuation in
            session.request(url, headers: headers)
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        continuation.resume(returning: data)
                    case .failure(let error):
                        // Check for network-related errors
                        if let urlError = error.asAFError?.underlyingError as? URLError,
                           urlError.code == .notConnectedToInternet {
                            continuation.resume(throwing: NetworkError.noInternetConnection)
                        } else if let responseCode = response.response?.statusCode {
                            continuation.resume(throwing: NetworkError.serverError(statusCode: responseCode))
                        } else {
                            continuation.resume(throwing: error)
                        }
                    }
                }
        }
        
        // Handle decoding errors
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}

