//
//  QuestionOverviewView.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 11/10/2024.
//

import SwiftUI

struct QuestionOverviewView: View {
    
    let movieOverview: String
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
        VStack {
            Text(movieOverview)
                .questionOverviewTextStyle()
                .lineSpacing(5)
                .multilineTextAlignment(.leading)
                .frame(height: 90, alignment: .center)
                .padding(.horizontal, 15)
                .background(StyleGuide.Color.background)
                .padding(1)
                .background(
                    Rectangle()
                        .strokeBorder(
                            style: StrokeStyle(lineWidth: 2, dash: [5])
                        )
                        .foregroundColor(StyleGuide.Color.primary)
                )
        }
        .frame(maxWidth: horizontalSizeClass == .regular ? 400 : .infinity)

    }
}

#Preview {
    QuestionOverviewView(movieOverview: "After a family tragedy, three generations of the Deetz family return home to Winter River. Still haunted by Betelgeuse, Lydia's life is turned upside down when her teenage daughter, Astrid, accidentally opens the portal to the Afterlife.")
}
