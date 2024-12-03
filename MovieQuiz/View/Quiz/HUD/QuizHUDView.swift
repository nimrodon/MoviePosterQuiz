//
//  QuizHUDView.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 29/09/2024.
//

import SwiftUI

struct QuizHUDView: View {
    
    let score: Int
    let lives: Int
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        VStack {
            HStack {
                Text("\(score)")
                    .HUDTextStyle()
                Spacer()
                QuizLivesView(lives: lives)
                QuizQuitButtonView(navigationPath: $navigationPath)
            }
        }
    }
}

#Preview {
    QuizHUDView(score: 1234, lives: 2, navigationPath: .constant(NavigationPath()))
}
