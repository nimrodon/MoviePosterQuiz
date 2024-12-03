//
//  QuizView.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 28/09/2024.
//

import SwiftUI

struct QuizView: View {
    
    @Binding var navigationPath: NavigationPath
    @EnvironmentObject var quizVM: QuizViewModel

    var body: some View {
        VStack {
            if let messageText = quizVM.messageText {
                Text(messageText)
                    .loaderTextStyle()
                    .multilineTextAlignment(.center)
            }
            else {
                ZStack {
                    VStack {
                        QuizHUDView(score: quizVM.score,
                                    lives: quizVM.lives,
                                    navigationPath: $navigationPath)
                        QuestionView(question: quizVM.questions[quizVM.currentQuestionIndex],
                                     questionNum: quizVM.currentQuestionIndex + 1)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    if quizVM.answerFeedback != nil {
                        AnswerFeedbackView(isCorrect: quizVM.answerFeedback!, points: quizVM.currentQuestionPoints)
                    }
                }
                
            }
        }
        .screenDefinitions()
        .navigationBarHidden(true)
        .onAppear() {
            quizVM.createNewQuiz()
        }
        .onDisappear() {
            quizVM.resetQuiz()
        }
        .onChange(of: quizVM.isQuizOver) { isQuizOver in
            if isQuizOver {
                navigationPath.append("QuizResults")
            }
        }
        .environmentObject(quizVM)
    }
}


#Preview {
    QuizView(navigationPath: .constant(NavigationPath()))
}
