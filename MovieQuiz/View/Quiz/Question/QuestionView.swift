//
//  QuizQuestionView.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 28/09/2024.
//

import SwiftUI

struct QuestionView: View {
    
    let question: Question
    let questionNum: Int
    
    @EnvironmentObject private var quizVM: QuizViewModel

    var body: some View {
        ZStack  {
            VStack {
                VStack {
                    Text("\(Strings.Quiz.questionCaption) \(questionNum)")
                        .HUDTextStyle()
                    QuestionOverviewView(movieOverview: question.movieOverview)
                        .padding(.bottom, 15)
                }
                VStack {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
                        ForEach(question.posterImages.indices, id: \.self) { index in
                            QuestionAnswerView(answerIndex: index,
                                               imageURL: question.posterImages[index])
                        }
                    }
                }
                .aspectRatio(2/3, contentMode: .fit)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if (quizVM.imagesLoadedCount < QuizConstants.numOfChoicesPerQuestion) {
                LoadingQuestionMessage()
            }
        }
    }
}


struct LoadingQuestionMessage: View {
    var body: some View {
        VStack {
            Text(Strings.Messages.loadingQuestion)
                .loaderTextStyle()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(StyleGuide.Color.background)
    }
}


#Preview {
    QuestionView( question: Question(movieOverview: "a cat without a home is planning to find a dog and marry him. he joins the army and has lots of adventures until he finds his true love.", posterImages: ["/quLtM0IhUdKSxs748MQUpQW2zia.jpg","/1s3NnoCbBbqEa50A4ch8WYLORti.jpg", "/3v6Bn9awDGOgANbDFCgZLw6RODJ.jpg","/cbf1YVagIXPgAEdN8CWsi3qzhlz.jpg"], correctAnswerIndex: 2), questionNum: 5)
}
