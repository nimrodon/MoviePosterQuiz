//
//  QuestionAnswerImageView.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 29/09/2024.
//

import SwiftUI

struct QuestionAnswerImageView: View {
    
    let imageURL: String

    @State private var retryCount = 0
    @EnvironmentObject private var quizVM: QuizViewModel

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: imageURL)) { phase in
                switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(2/3, contentMode: .fit)
                            .onAppear {
                                quizVM.imagesLoadedCount += 1
                            }
                    case .failure:
                        onAppear {
                            if retryCount < 3 {
                                retryCount  += 1
                            }
                            else {
                                quizVM.handleImageLoadingFailure()
                            }
                        }
                    default:
                        EmptyView()
                }
            }
            .id(imageURL)
        }
        .background(StyleGuide.Color.background)
    }
}

