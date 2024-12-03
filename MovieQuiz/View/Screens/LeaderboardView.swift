//
//  LeaderboardView.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 02/10/2024.
//
import SwiftUI

struct LeaderboardView: View {
    
    var body: some View {
        VStack {
            GameCenterView(leaderboardID: LeaderboardService.scoreLeaderboardId)
        }
        .screenDefinitions()
    }
}

#Preview {
    LeaderboardView()
}
