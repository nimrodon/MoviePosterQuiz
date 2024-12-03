//
//  MenuViewModel.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 01/10/2024.
//

import Foundation

class MenuViewModel: ObservableObject {
    
    @Published var highScore: Int = 0
    
    public func refreshHighScore() {
        highScore = UserDefaultsHelper.getHighScore()
    }
}
