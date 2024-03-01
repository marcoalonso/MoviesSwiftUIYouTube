//
//  MoviesDemoApp.swift
//  MoviesDemo
//
//  Created by Marco Alonso Rodriguez on 18/01/24.
//

import SwiftUI

@main
struct MoviesDemoApp: App {
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .preferredColorScheme(isDarkModeOn ? .dark : .light)
        }
    }
}
