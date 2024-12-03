//
//  QuizGenerator.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 27/09/2024.
//

import Foundation
import Combine

class QuizGenerator {
    
    var movieService: MovieServiceProtocol
    var cancellables = Set<AnyCancellable>()

    
    init() {
        movieService = TMDBMovieService()
    }
    
    
    public func generateQuestions(numOfQuestions: Int, completion: @escaping ([Question]?) -> Void) {
     
        generateQuestionsWithService(movieService, numOfQuestions: numOfQuestions) { [weak self] questions in
            guard let self = self else {
                completion(nil)
                return
            }
            
            if let questions = questions, !questions.isEmpty {
                completion(questions)
            } else {
                print ("switching to local movies")
                self.movieService = LocalMovieService()
                self.generateQuestionsWithService(self.movieService, numOfQuestions: numOfQuestions, completion: completion)
            }
        }
    }
    
    
    // --------- private methods ----------

    private func generateQuestionsWithService(_ service: MovieServiceProtocol, numOfQuestions: Int, completion: @escaping ([Question]?) -> Void) {
        let numOfMovies = numOfQuestions * QuizConstants.numOfChoicesPerQuestion
        
        service.getRandomMovies(amount: numOfMovies)
            .map { movies in
                self.createQuestions(from: movies)
            }
            .sink(receiveCompletion: { completionStatus in
                switch completionStatus {
                case .finished:
                    print("Service finished successfully.")
                case .failure(let error):
                    print("Service failed with error: \(error.localizedDescription)")
                    completion(nil) 
                }
            }, receiveValue: { questions in
                completion(questions)
            })
            .store(in: &cancellables)
    }


    private func createQuestions(from movies: [Movie]) -> [Question] {
        let movieChunks = chunkMovies(movies, chunkSize: QuizConstants.numOfChoicesPerQuestion)
        
        return movieChunks.map { chunk in
            let correctAnswerIndex = Int.random(in: 0..<QuizConstants.numOfChoicesPerQuestion)
            let movieOverview = chunk[correctAnswerIndex].overview
            let posterImages = chunk.map { $0.posterImage }
            
            return Question(movieOverview: movieOverview, posterImages: posterImages, correctAnswerIndex: correctAnswerIndex)
        }
    }
    
    
    private func chunkMovies(_ movies: [Movie], chunkSize: Int) -> [[Movie]] {
        var chunks: [[Movie]] = []
        for i in stride(from: 0, to: movies.count, by: chunkSize) {
            let endIndex = min(i + chunkSize, movies.count)
            let chunk = Array(movies[i..<endIndex])
            chunks.append(chunk)
        }
        return chunks
    }

}
