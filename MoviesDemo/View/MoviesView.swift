//
//  MoviesView.swift
//  MoviesDemo
//
//  Created by Marco Alonso Rodriguez on 18/01/24.
//

import SwiftUI
import Kingfisher

struct MoviesView: View {
    @StateObject private var viewModel = MoviesViewModel()
    
    var gridITemLayout = [GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Proximos estrenos")
                        .font(.title2)
                        .foregroundColor(.accentColor)
                    
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: gridITemLayout, spacing: 20) {
                            ForEach(viewModel.upcomingMovies, id: \.id) { movie in
                                NavigationLink {
                                    EmptyView()
                                } label: {
                                    KFImage(URL(string: "\(Constants.urlImages)\(movie.poster_path ?? Constants.placeholder)"))
                                        .resizable()
                                        .placeholder { progress in
                                            ProgressView()
                                        }
                                        .cornerRadius(12)
                                        .frame(width: 150, height: 210)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MoviesView()
}
