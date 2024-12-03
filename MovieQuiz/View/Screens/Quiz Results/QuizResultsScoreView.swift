//
//  QuizResultsScoreView.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 01/12/2024.
//

import SwiftUI

struct QuizResultsScoreView: View {
        
    let caption: String
    let score: Int
    let withSpacing: Bool
    
    init(caption: String, score: Int, withSpacing: Bool = true) {
        self.caption = caption
        self.score = score
        self.withSpacing = withSpacing
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(caption):")
                if (withSpacing) {
                    Spacer()
                }
                Text("\(score)")
            }
            .padding()
        }
        .headerTextStyle()
    }
}

#Preview {
    QuizResultsScoreView(caption: "Score:", score: 1234)
}
