//
//  TMDBServiceLogics.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 14/10/2024.
//

import Foundation
import Combine

class TMDBMovieQueryHelper {

    let maxPageNum = 500
    let resultsPerPage = 20
    let averageValidMoviesPercentage = 0.2
    let queryStrings: [String] = ["a","b","c","d","e","f","g","h","i","J","k","l","m","n","o","p","r","s","t","u","v","w","y","z"]
    let movieSearchURL  = "https://api.themoviedb.org/3/search/movie?query=<query>&page=<page>&include_adult=false"
    let baseImageURL = "https://image.tmdb.org/t/p/w500"
    let maxConcurrentFetches = 20
    let minVoteCount = 50
    let minVoteAverage = 5.0

    var averageValidMoviesPerFetch: Double

    
    init() {
        averageValidMoviesPerFetch = Double(resultsPerPage) * averageValidMoviesPercentage
    }
            
    
    public func createRandomMoviesURLString() -> String  {
        let pageNum = Int.random(in: 1...maxPageNum)
        let queryString = queryStrings.randomElement()!
        let urlString = movieSearchURL
            .replacingOccurrences(of: "<query>", with: queryString)
            .replacingOccurrences(of: "<page>", with: String(pageNum))

        return urlString
    }

    
    public func getNumOfFetches(numOfMovies: Int) -> Int {
        let numOfFetchesNeeded =  Int(ceil(Double(numOfMovies) / averageValidMoviesPerFetch))
        return min(numOfFetchesNeeded, maxConcurrentFetches)
    }

    
    public func validateMovie(_ tmdbMovie: TMDBMovie) -> Bool {
        return  !tmdbMovie.overview.isEmpty &&
                tmdbMovie.posterImage != nil &&
                !tmdbMovie.posterImage!.isEmpty &&
                tmdbMovie.voteAverage != nil &&
                tmdbMovie.voteAverage! >= minVoteAverage &&
                tmdbMovie.voteCount != nil &&
                tmdbMovie.voteCount! >= minVoteCount
    }

    
    public func convertToAppMovie(_ tmdbMovie: TMDBMovie) -> Movie {
        return  Movie(
                    id: tmdbMovie.id,
                    title: tmdbMovie.title,
                    overview: tmdbMovie.overview,
                    posterImage: baseImageURL + tmdbMovie.posterImage!
                )
    }

}
