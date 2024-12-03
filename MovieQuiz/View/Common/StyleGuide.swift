//
//  StyleGuide.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 29/09/2024.
//

import SwiftUI

struct StyleGuide {
    
    // Fonts
    
    struct AppFont {

        static let fontName = "Merriweather-Regular"
        static let fontNameBold = "Merriweather-Bold"

        static let title = font(name: fontNameBold, size: 36, weight: .bold)
        static let header = font(name: fontNameBold, size: 24, weight: .bold)
        static let body = font(name: fontName, size: 20, weight: .regular)

        static let loader = font(name: fontNameBold, size: 20, weight: .bold)
        static let HUD = font(name: fontNameBold, size: 24, weight: .bold)
        static let HUDIcons = font(name: fontName, size: 20, weight: .bold)
        static let questionHeader = font(name: fontNameBold, size: 24, weight: .bold)
        static let questionFeebdack = font(name: fontName, size: 36, weight: .regular)
        static let questionOverview = font(name: fontName, size: 17, weight: .regular)

        
        private static func font(name: String, size: CGFloat, weight: Font.Weight) -> SwiftUI.Font {
            if let _ = UIFont(name: name, size: size) {
                return SwiftUI.Font.custom(name, size: size)
            } else {
                return SwiftUI.Font.system(size: size, weight: weight)
            }
        }
    }

    
    //Colors

    struct Color {
        
        static let primary = SwiftUI.Color.white
        static let background = SwiftUI.Color.black
        static let correct = SwiftUI.Color.green
        static let incorrect = SwiftUI.Color.red
    
    }
}

