//
//  Components.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 01/12/2024.
//

import SwiftUI

struct TrophyIconView: View {
    
    var body: some View {
        Image(systemName: "trophy.fill")
            .font(StyleGuide.AppFont.title)
            .foregroundColor(.yellow)
    }
}

