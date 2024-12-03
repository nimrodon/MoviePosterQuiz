//
//  MovieQuizApp.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 27/09/2024.
//

import SwiftUI

@main
struct MovieQuizApp: App {
        
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
    
    init() {
        LeaderboardService.authenticateGameCenterUser()
    }
}
