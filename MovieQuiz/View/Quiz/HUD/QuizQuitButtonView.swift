//
//  QuizQuitButton.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 01/10/2024.
//

import SwiftUI

struct QuizQuitButtonView: View {
    
    @Binding var navigationPath: NavigationPath

    var body: some View {
        Button(action: {
            navigationPath.removeLast()
        }, label: {
            Image(systemName: "arrow.uturn.left")
        })
        .font(StyleGuide.AppFont.HUDIcons)
    }
}


#Preview {
    QuizQuitButtonView(navigationPath: .constant(NavigationPath()))
}
