//
//  InstructionsView.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 01/10/2024.
//

import SwiftUI

struct InstructionsView: View {
    
    var body: some View {
        VStack {
            Text(Strings.Instructions.title)
                .headerTextStyle()
                .padding()
            Text(Strings.Instructions.description)
                .bodyTextStyle()
        }
        .padding()
        .screenDefinitions()
    }
}

#Preview {
    InstructionsView()
}
