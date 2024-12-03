//
//  TMDBServiceProtocol.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 27/09/2024.
//

import Foundation
import Combine

protocol MovieServiceProtocol {
    
    func getRandomMovies(amount: Int) -> AnyPublisher<[Movie], NetworkError>
    
}
