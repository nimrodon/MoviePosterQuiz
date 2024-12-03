//
//  ContentView.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 27/09/2024.
//

import SwiftUI

struct MainView: View {
    
    @State private var navigationPath = NavigationPath()
    @StateObject private var quizVM = QuizViewModel() 
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            MenuView(navigationPath: $navigationPath)
                .navigationDestination(for: String.self) { value in
                    switch value {
                        case NavigationConstants.quiz:
                                QuizView(navigationPath: $navigationPath)
                                    .environmentObject(quizVM)
                        case NavigationConstants.quizResults:
                                QuizResultsView(navigationPath: $navigationPath)
                                    .environmentObject(quizVM)
                        case NavigationConstants.instructions:
                                InstructionsView()
                        case NavigationConstants.credits:
                                CreditsView()
                        default:
                            EmptyView()
                    }
                }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .padding()
        .screenDefinitions()
    }
}


#Preview {
    MainView()
}
