//
//  CreditsView.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 01/10/2024.
//

import SwiftUI

struct CreditsView: View {
    
    var body: some View {
        VStack {
            Text(Strings.Credits.title)
                .headerTextStyle()
                .padding()
            VStack {
                Text(Strings.Credits.mainCredits)
                    .bodyTextStyle()
                    .multilineTextAlignment(.center)
                    .padding()
                VStack {
                    Text(Strings.Credits.poweredBy)
                        .bodyTextStyle()
                    Link(Strings.Credits.MovieServiceName,
                         destination: URL(string: Strings.Credits.MovieServiceURL)!)
                        .font(StyleGuide.AppFont.body)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
        .screenDefinitions()
    }
}

#Preview {
    CreditsView()
}
