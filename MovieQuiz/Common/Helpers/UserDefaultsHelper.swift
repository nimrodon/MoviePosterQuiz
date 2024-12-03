//
//  UserDefaultsHelper.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 02/10/2024.
//

import Foundation

class UserDefaultsHelper {

    public static let highScoreKey = "highScore"

    public static func getHighScore() -> Int {
        return UserDefaults.standard.integer(forKey: highScoreKey)
    }
    
    public static func setHighScore(score: Int) {
        UserDefaults.standard.setValue(score, forKey: highScoreKey)
    }
    
}
