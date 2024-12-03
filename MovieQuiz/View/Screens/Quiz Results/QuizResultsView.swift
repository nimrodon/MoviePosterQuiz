//
//  QuizResultsView.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 01/10/2024.
//

import SwiftUI

struct QuizResultsView: View {
    
    @Binding var navigationPath: NavigationPath
    @EnvironmentObject var quizVM: QuizViewModel

    var body: some View {
        VStack {
            Spacer()
            Text(Strings.QuizResults.title)
                .titleTextStyle()
            Spacer()
            QuizResultsContentView()
            Spacer()
            VStack {
                MenuItemView(title: Strings.QuizResults.playAgainButton) {
                    navigationPath.removeLast()
                }
                MenuItemView(title: Strings.QuizResults.returnToMenuButton) {
                    navigationPath.removeLast(navigationPath.count)
                }
            }
            .frame(maxWidth: 250)
            Spacer()
        }
        .screenDefinitions()
        .navigationBarHidden(true)
    }
}

#Preview {
    QuizResultsView(navigationPath: .constant(NavigationPath()))
}
