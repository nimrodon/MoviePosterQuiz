//
//  QuizModel.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 27/09/2024.
//

import Foundation

struct Movie: Codable {
    
    let id: Int
    
    let title: String

    let overview: String

    let posterImage: String
    
}


struct Question {
    
    let movieOverview: String

    let posterImages: [String]

    let correctAnswerIndex: Int
}



