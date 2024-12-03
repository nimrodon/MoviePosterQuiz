//
//  AnswerFeedbackView.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 29/09/2024.
//

import SwiftUI

struct AnswerFeedbackView: View {

    let isCorrect: Bool
    let points: Int 
    @EnvironmentObject private var quizVM: QuizViewModel

    @State private var feedbackTextOffset: CGFloat = 0
    private let outsideLeftTextOffset: CGFloat = -300
    private let outsideRightTextOffset: CGFloat = 300

    var body: some View {
        VStack {
            Text(isCorrect ? Strings.Quiz.correctFeedack : Strings.Quiz.wrongFeedack)
            if isCorrect {
                Text("+\(points)")
            }
        }
        .questionFeebdackTextStyle()
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(isCorrect ? StyleGuide.Color.correct : StyleGuide.Color.incorrect)
                .shadow(radius: 5)
        )
        .offset(x: feedbackTextOffset, y: 0)
        .onAppear() {
            feedbackTextOffset = outsideLeftTextOffset
            Task {
                await animateFeedbackText()
                quizVM.handleQuestionCompleted()
            }
        }
    }
    
    private func animateFeedbackText() async {
        feedbackTextOffset = outsideLeftTextOffset
        withAnimation(.easeInOut(duration: 0.5)) {
            feedbackTextOffset = 0
        }
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        withAnimation(.easeInOut(duration: 0.5)) {
            feedbackTextOffset = outsideRightTextOffset
        }
        try? await Task.sleep(nanoseconds: 500_000_000)
        feedbackTextOffset = outsideLeftTextOffset
    }
}

#Preview {
    AnswerFeedbackView(isCorrect: true, points: 87)
}
