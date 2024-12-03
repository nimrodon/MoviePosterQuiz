//
//  LocalMoviesService.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 10/11/2024.
//

import Foundation
import Combine

class LocalMovieService: MovieServiceProtocol {
    
    var movies: [Movie] = []
    
    
    public func getRandomMovies(amount: Int) -> AnyPublisher<[Movie], NetworkError> {
        
        if movies.isEmpty {
            loadMoviesFromFile()
        }
        let randomMovies = Array(movies.shuffled().prefix(min(amount, movies.count)))
        return Just(randomMovies)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }

        
    private func loadMoviesFromFile() {
        if let url = Bundle.main.url(forResource: "local_movies", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let response = try JSONDecoder().decode([Movie].self, from: data)
                movies = response
            } catch {
                let error = "Error loading movies: \(error.localizedDescription)"
                print(error)
            }
        }
        else {
            print ("error: movies file not found")
        }
    }
            
}
    
