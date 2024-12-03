//
//  ViewExtension.swift
//  MovieQuiz
//
//  Created by Nimrod Yizhar on 06/10/2024.
//

import SwiftUI

extension View {
    
    // Common screen modifier
    
    public func screenDefinitions() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(StyleGuide.Color.background.edgesIgnoringSafeArea(.all))
    }
    
    
    // Text Styling modifiers
    
    public func titleTextStyle() -> some View {
        self.font(StyleGuide.AppFont.title)
            .foregroundColor(StyleGuide.Color.primary)
    }
    
    public func headerTextStyle() -> some View {
        self.font(StyleGuide.AppFont.header)
            .foregroundColor(StyleGuide.Color.primary)
    }

    public func bodyTextStyle() -> some View {
        self.font(StyleGuide.AppFont.body)
            .foregroundColor(StyleGuide.Color.primary)
    }

    public func loaderTextStyle() -> some View {
        self.font(StyleGuide.AppFont.loader)
            .foregroundColor(StyleGuide.Color.primary)
    }

    public func MenuItemTextStyle() -> some View {
        self.font(StyleGuide.AppFont.header)
            .foregroundColor(StyleGuide.Color.background)
    }

    public func HUDTextStyle() -> some View {
        self.font(StyleGuide.AppFont.HUD)
            .foregroundColor(StyleGuide.Color.primary)
    }

    public func questionOverviewTextStyle() -> some View {
        self.font(StyleGuide.AppFont.questionOverview)
            .foregroundColor(StyleGuide.Color.primary)
    }

    public func questionFeebdackTextStyle() -> some View {
        self.font(StyleGuide.AppFont.questionFeebdack)
            .foregroundColor(StyleGuide.Color.primary)
    }

}
