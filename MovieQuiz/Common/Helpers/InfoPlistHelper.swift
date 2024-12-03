//
//  InfoPlistHelper.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 14/10/2024.
//

import Foundation

class InfoPlistHelper {

    public static func getTMDBAccessToken() -> String? {
        if let token = Bundle.main.object(forInfoDictionaryKey: "TMDB_ACCESS_TOKEN") as? String {
            return token
        }
        return nil
    }

    public static func getGameCenterLeaderboardID() -> String? {
        if let token = Bundle.main.object(forInfoDictionaryKey: "GAME_CENTER_LEADERBOARD_ID") as? String {
            return token
        }
        return nil
    }

}
