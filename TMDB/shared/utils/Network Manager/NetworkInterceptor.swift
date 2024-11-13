//
//  NetworkInterceptor.swift
//  TMDB
//
//  Created by Khin Phone Ei on 13/11/2024.
//

import Foundation
import Alamofire

class NetworkInterceptor: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        
        let bearerToken = "Bearer " + "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMDMwYTE5ZWNjNGNhNWEyNWNlYTg3NTNiMzQ0MDQ1OSIsIm5iZiI6MTczMTQ5NTM4Ni4zNTU0ODgzLCJzdWIiOiI2NWEzNWEyMDdkNWY0YjAwY2JiN2M3Y2UiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.VYxqjxeBAiMm_zuChBuY_XtREAWQwXnmzhnnXGabpFY"
        request.setValue(bearerToken, forHTTPHeaderField: "Authorization")
        
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            guard request.retryCount < 3 else {
                completion(.doNotRetry)
                return
            }
        }
    }
}
