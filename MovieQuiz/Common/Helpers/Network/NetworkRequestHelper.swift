//
//  NetworkRequestHelper.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 06/05/2024.
//

import Foundation
import Combine

class NetworkRequestHelper {
    
    public static func createRequestWithURLString(_ urlString: String, accessToken: String? = nil) -> URLRequest? {
        guard let url = URL(string: urlString) else {
            NSLog("Bad URL: \(urlString)")
            return nil
        }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = accessToken {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
    

    public static func fetchJSON<T: Decodable>(_ type: T.Type, from request: URLRequest) -> AnyPublisher<T, NetworkError> {
        return fetchData(for: request)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let decodingError = error as? DecodingError {
                    return NetworkError.parsingFailure(description: decodingError.localizedDescription)
                }
                return error as? NetworkError ?? NetworkError.unknown(description: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
    

    public static func shouldRetryRequest(for error: NetworkError) -> Bool {
        switch error {
            case .noInternet, .urlSessionError:
                return true
            case .httpFailure(let statusCode, _):
                return (500...599).contains(statusCode) || statusCode == 429
            default:
                return false
            }
    }
    
    
    private static func fetchData(for request: URLRequest, maxRetries: Int = 3, retryDelay: TimeInterval = 1.0)  -> AnyPublisher<Data, NetworkError> {
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.unknown(description: "Invalid HTTP response")
                }
                guard (200...299).contains(httpResponse.statusCode) else {
                    let description = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                    throw NetworkError.httpFailure(statusCode: httpResponse.statusCode, description: description)
                }
                return data
            }
            .mapError { error in
                mapErrorToNetworkError(error)
            }
            .retry(maxRetries)
            .eraseToAnyPublisher()
    }
    

    private static func mapErrorToNetworkError(_ error: Error) -> NetworkError {
       if let networkError = error as? NetworkError {
           return networkError
       } else if let urlError = error as? URLError {
           if urlError.code == .notConnectedToInternet {
               return .noInternet
           }
           else {
               return .urlSessionError(description: urlError.localizedDescription)
           }
       } else {
           return .unknown(description: error.localizedDescription)
       }
   }
    
}
