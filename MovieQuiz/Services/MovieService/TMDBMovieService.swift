//
//  TMDBService.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 27/09/2024.
//

import Foundation
import Combine

class TMDBMovieService: MovieServiceProtocol {

    var queryHelper: TMDBMovieQueryHelper

    
    init() {
        queryHelper = TMDBMovieQueryHelper()
    }

    
    public func getRandomMovies(amount: Int) -> AnyPublisher<[Movie], NetworkError> {
        return fetchRandomMoviesUntilTarget(currentMovies: [], targetNumOfMovies: amount)
    }
        
    
    // ----- private methods -----

    // Movies are fetched with multiple concurent fetches and merged into a single array.
    // This is done recursively because we don't know how many valid movies will be in each fetch.

    private func fetchRandomMoviesUntilTarget(currentMovies: [Movie], targetNumOfMovies: Int) -> AnyPublisher<[Movie], NetworkError> {
        
        print("fetch random movies until target. target = \(targetNumOfMovies), current = \(currentMovies.count)")

        if currentMovies.count >= targetNumOfMovies {
             
            let resultMovies = Array(currentMovies.prefix(targetNumOfMovies))
            //DebugHelper.printMoviesAsJSON(resultMovies)

            return Just(resultMovies)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }

        let numOfFetches = queryHelper.getNumOfFetches(numOfMovies: targetNumOfMovies - currentMovies.count)
        var publishers: [AnyPublisher<[Movie], NetworkError>] = []
        for _ in 0..<numOfFetches {
            let publisher = fetchRandomMoviesBatch()
            publishers.append(publisher)
        }

        return Publishers.MergeMany(publishers)
            .collect()
            .flatMap { movieArrays -> AnyPublisher<[Movie], NetworkError> in
                let newMovies = movieArrays.flatMap { $0 }
                let combinedMovies = currentMovies + newMovies

                // fetch movies again until target is met
                return self.fetchRandomMoviesUntilTarget(currentMovies: combinedMovies, targetNumOfMovies: targetNumOfMovies)
            }
            .eraseToAnyPublisher()
    }
    

    private func fetchRandomMoviesBatch() -> AnyPublisher<[Movie], NetworkError> {
        
        let urlString = queryHelper.createRandomMoviesURLString()
        
        let accessToken = InfoPlistHelper.getTMDBAccessToken()
        guard let request = NetworkRequestHelper.createRequestWithURLString(urlString, accessToken: accessToken) else {
            return Fail(error: NetworkError.invalidURL)
                 .eraseToAnyPublisher()
         }
        
        return NetworkRequestHelper.fetchJSON(TMDBMoviesResponse.self, from: request)
            .map { [self] tmdbMoviesResponse in
                tmdbMoviesResponse.results
                    .filter { tmdbMovie in
                        queryHelper.validateMovie(tmdbMovie)
                    }
                    .map { tmdbMovie in
                        queryHelper.convertToAppMovie(tmdbMovie)
                    }
            }
            .eraseToAnyPublisher()
    }
 
}
