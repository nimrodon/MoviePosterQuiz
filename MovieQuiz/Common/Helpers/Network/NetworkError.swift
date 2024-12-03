//
//  NetworkError.swift
//  MaccabiExercise
//
//  Created by Nimrod Yizhar on 06/05/2024.
//

import Foundation
    
enum NetworkError: Error, CustomStringConvertible {
    
    case noInternet
    case httpFailure(statusCode: Int, description: String)
    case parsingFailure(description: String)
    case invalidURL
    case urlSessionError(description: String)
    case unknown(description: String)

    
    var description: String {
        switch self {
            case .noInternet:
                return "No Internet Connection"
            case .httpFailure(let statusCode, let description):
                return "HTTP Error \(statusCode): \(description)"
            case .parsingFailure(let description):
                return "Parsing Error: \(description)"
            case .invalidURL:
                return "Invalid URL"
            case .urlSessionError(let description):
                return "URLSession Error: \(description)"
            case .unknown(let description):
                return "Unknown Error: \(description)"
        }
    }
}
