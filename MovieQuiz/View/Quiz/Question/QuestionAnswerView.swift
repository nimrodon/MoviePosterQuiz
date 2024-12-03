//
//  QuestionAnswerImageView.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 28/09/2024.
//

import Foundation
import SwiftUI

struct QuestionAnswerView: View {
    
    let answerIndex: Int
    let imageURL: String
    @EnvironmentObject private var quizVM: QuizViewModel

    var body: some View {
        VStack {
            VStack {
                Button(action: {
                    quizVM.handleUserAnswer(answerIndex)
                }, label: {
                    QuestionAnswerImageView(imageURL: imageURL)
                })
                .disabled(!quizVM.isQuestionActive)
            }
            .padding(2)
            .background(
                RoundedRectangle(cornerRadius: 2)
                    .fill(StyleGuide.Color.primary)
                )
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 5)
               .fill(getHighlightColor())
            )
    }
    
    
    private func getHighlightColor() -> Color {
        var highlightColor = Color.clear
        if quizVM.answerFeedback != nil {
            let correctAnswerIndex = quizVM.getCorrectAnswerIndex()
            if answerIndex == correctAnswerIndex {
                highlightColor = StyleGuide.Color.correct
            }
            else if answerIndex == quizVM.selectedIndex {
                highlightColor = StyleGuide.Color.incorrect
            }
        }
        return highlightColor
    }
    
}

