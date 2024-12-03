//
//  MenuView.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 01/10/2024.
//

import SwiftUI

struct MenuView: View {

    @Binding var navigationPath: NavigationPath
    @StateObject private var menuVM: MenuViewModel = MenuViewModel()
    @State private var showGameCenter = false
    
    var body: some View {
        VStack {
            
            VStack {
                Text(Strings.mainTitle)
                    .titleTextStyle()
                    .padding(.vertical)
                if menuVM.highScore > 0 {
                    HStack {
                        TrophyIconView()
                        Text("\(menuVM.highScore)")
                            .headerTextStyle()
                    }
                    .padding(.vertical)
                }
                
            }
            .padding(.vertical)
            
            VStack {
                MenuItemView(title: Strings.Menu.startQuiz) {
                    navigationPath.append(NavigationConstants.quiz)
                }
                MenuItemView(title: Strings.Menu.leaderboard) {
                    showGameCenter.toggle()
                }
                MenuItemView(title: Strings.Menu.instructions) {
                    navigationPath.append(NavigationConstants.instructions)
                }
                MenuItemView(title: Strings.Menu.credits) {
                    navigationPath.append(NavigationConstants.credits)
                }
            }
            .frame(maxWidth: 250)
            
        }
        .screenDefinitions()
        .fullScreenCover(isPresented: $showGameCenter) {
            LeaderboardView()
        }
        .onAppear() {
            menuVM.refreshHighScore()
        }
    }
}


#Preview {
    MenuView(navigationPath: .constant(NavigationPath()))
}
