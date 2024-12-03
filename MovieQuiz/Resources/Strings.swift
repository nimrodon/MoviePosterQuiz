//
//  Strings.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 13/11/2024.
//

struct Strings {

    static let mainTitle =  "Movie Poster Quiz"
    
    struct Menu {
        static let startQuiz = "Start Quiz"
        static let leaderboard = "Leaderboard"
        static let instructions = "Instructions"
        static let credits = "Credits"
    }
    
    struct Quiz {
        static let questionCaption = "Question"
        static let correctFeedack = "Correct!"
        static let wrongFeedack = "Wrong!"
    }

    struct QuizResults {
        static let title = "Quiz Results"
        static let newHighScore = "New High Score!"
        static let highScore = "high score"
        static let score = "score"
        static let playAgainButton = "Play Again"
        static let leadboardButton = "Leaderboard"
        static let returnToMenuButton = "Main Menu"
    }
    
    struct Messages {
        static let creatingQuiz = "Preparing Quiz..."
        static let loadingQuestion = "Loading..."
        static let connectionError = "*** Connection Error *** \nPlease try again later."
    }
    
    struct Instructions {
        static let title = "Instructions:"
        static let description = "Match the movie overview to the correct movie poster below. Answer quickly for more points."
    }
    
    struct Credits {
        static let title = "Credits:"
        static let mainCredits = "Designed and Developed by Nimrod Yizhar"
        static let poweredBy = "Powered by"
        static let MovieServiceName = "TMDB: The Movie Database"
        static let MovieServiceURL = "https://www.themoviedb.org/"
    }
    
}
