//
//  MenuItemView.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 03/10/2024.
//

import SwiftUI

struct MenuItemView: View {
    
    let title: String
    let action: (() -> Void)
    
    var body: some View {
        VStack {
            Button(action: action) {
                Text(title)
                    .MenuItemTextStyle()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(StyleGuide.Color.primary)
                    .cornerRadius(8)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

#Preview {
    MenuItemView(title: "Instructions", action: {})
}
