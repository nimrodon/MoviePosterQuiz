//
//  LeaderboardService.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 02/10/2024.
//

import GameKit

class LeaderboardService {

    public static let scoreLeaderboardId: String = {
         return InfoPlistHelper.getGameCenterLeaderboardID() ?? ""
     }()
    
    public static func authenticateGameCenterUser() {
        
        GKLocalPlayer.local.authenticateHandler = { vc, error in
            if let vc = vc {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.rootViewController?.present(vc, animated: true)
                }
            } else if GKLocalPlayer.local.isAuthenticated {
                print("Game Center user authenticated")
            } else {
                if let error = error {
                    print("Game Center authentication failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    public static func reportScore(score: Int) {
        if !scoreLeaderboardId.isEmpty {
            GKLeaderboard.submitScore(score, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [scoreLeaderboardId]) { error in
                if let error = error {
                    print("Failed to report score: \(error.localizedDescription)")
                } else {
                    print("Score reported successfully")
                }
            }
        }
    }

}
