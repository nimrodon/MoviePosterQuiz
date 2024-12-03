//
//  QuizResultsContentView.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 02/10/2024.
//

import SwiftUI

struct QuizResultsContentView: View {
    
    @EnvironmentObject private var quizVM: QuizViewModel
    
    var body: some View {
        VStack {
            if quizVM.isNewHighScore {
                TrophyIconView()
                Text(Strings.QuizResults.newHighScore)
                    .font(StyleGuide.AppFont.header)
                    .foregroundColor(.red)
                    .padding()
                QuizResultsScoreView(caption: Strings.QuizResults.score,
                                     score: quizVM.score,
                                     withSpacing: false)
            }
            else {
                QuizResultsScoreView(caption: Strings.QuizResults.score,
                                     score: quizVM.score)
                QuizResultsScoreView(caption: Strings.QuizResults.highScore,
                                     score: quizVM.highScore)
            }
        }
        .frame(maxWidth: 300)
    }
}
    



#Preview {
    QuizResultsContentView()
}
