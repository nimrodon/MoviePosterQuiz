//
//  QuizLivesView.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 29/09/2024.
//

import SwiftUI

struct QuizLivesView: View {
    
    let lives: Int
    
    var body: some View {
        HStack {
            ForEach((0..<QuizConstants.maxLives).reversed(), id: \.self) { index in
                if index < lives {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                } else {
                    Image(systemName: "heart")
                        .foregroundColor(.gray)
                }
            }
        }
        .font(StyleGuide.AppFont.HUDIcons)
    }
}

#Preview {
    QuizLivesView(lives: 2)
}
