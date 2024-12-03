//
//  DebugUtil.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 11/11/2024.
//

import Foundation

class DebugHelper {
    
    public static func printMoviesAsJSON(_ movies: [Movie]) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        do {
            let jsonData = try encoder.encode(movies)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("--------------- movies.json ----------------")
                print(jsonString)
                print("--------------- -------------------------------")
             }
        } catch {
            print("Failed to encode questions: \(error)")
        }
    }

}
