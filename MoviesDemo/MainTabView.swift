//
//  MainTabView.swift
//  MoviesDemo
//
//  Created by Marco Alonso Rodriguez on 21/01/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            MoviesView()
                .tabItem {
                    Image(systemName: "play.rectangle")
                }
            
            SearchMoviesView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            
            FeedbackView()
                .tabItem {
                    Image(systemName: "gearshape")
                }
        }
    }
}

#Preview {
    MainTabView()
}
