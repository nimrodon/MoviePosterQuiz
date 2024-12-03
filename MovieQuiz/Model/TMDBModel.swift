//
//  TMDBModel.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 27/09/2024.
//

import Foundation

struct TMDBMovie: Codable {

    let id: Int

    let title: String

    let overview: String

    let posterImage: String?
    
    let voteAverage: Double?

    let voteCount: Int?
    

    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterImage = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct TMDBMoviesResponse: Codable {
    let results: [TMDBMovie]
}


