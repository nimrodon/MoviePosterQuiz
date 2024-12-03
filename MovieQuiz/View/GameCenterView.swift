//
//  GameCenterView.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 02/10/2024.
//

import SwiftUI
import GameKit

struct GameCenterView: UIViewControllerRepresentable {

    let leaderboardID: String
    
    public func makeUIViewController(context: Context) -> GKGameCenterViewController {
        let gcVC = GKGameCenterViewController(leaderboardID: leaderboardID, playerScope: .global, timeScope: .allTime)
        gcVC.gameCenterDelegate = context.coordinator
        return gcVC
    }
    
    
    public func updateUIViewController(_ uiViewController: GKGameCenterViewController, context: Context) {
    }
    
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    class Coordinator: NSObject, GKGameCenterControllerDelegate {
        var parent: GameCenterView
        
        init(_ parent: GameCenterView) {
            self.parent = parent
        }
        
        public func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
            gameCenterViewController.dismiss(animated: true)
        }
    }
}

