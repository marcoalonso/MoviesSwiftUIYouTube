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
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("Proximos estrenos")
                        .font(.title2)
                        .foregroundColor(.accentColor)
                    
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: gridITemLayout, spacing: 20) {
                            ForEach(viewModel.upcomingMovies, id: \.id) { movie in
                                NavigationLink {
                                    MovieDetailView(movie: movie)
                                        
                                } label: {
                                    KFImage(URL(string: "\(Constants.urlImages)\(movie.poster_path ?? Constants.placeholder)"))
                                        .resizable()
                                        .placeholder { progress in
                                            ProgressView()
                                        }
                                        .cornerRadius(12)
                                        .frame(width: 150, height: 210)
                                        .task {
                                            if viewModel.hasReachedEnd(of: movie) && !viewModel.isFetching {
                                                await viewModel.fetchNextSetOfMovies()
                                            }
                                        }
                                }
                            }
                        }
                    }
                    
                    Text("Ahora en cartelera")
                        .font(.title2)
                        .foregroundColor(.accentColor)
                    
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: gridITemLayout, spacing: 20) {
                            ForEach(viewModel.nowPlayingMovies, id: \.id) { movie in
                                NavigationLink {
                                    MovieDetailView(movie: movie)
                                } label: {
                                    KFImage(URL(string: "\(Constants.urlImages)\(movie.poster_path ?? Constants.placeholder)"))
                                        .resizable()
                                        .placeholder { progress in
                                            ProgressView()
                                        }
                                        .cornerRadius(12)
                                        .frame(width: 120, height: 170)
                                }
                            }
                        }
                    }
                    
                    Text("Tendencias")
                        .font(.title2)
                        .foregroundColor(.accentColor)
                    
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: gridITemLayout, spacing: 20) {
                            ForEach(viewModel.trendingMovies, id: \.id) { movie in
                                NavigationLink {
                                    MovieDetailView(movie: movie)
                                } label: {
                                    KFImage(URL(string: "\(Constants.urlImages)\(movie.poster_path ?? Constants.placeholder)"))
                                        .resizable()
                                        .placeholder { progress in
                                            ProgressView()
                                        }
                                        .cornerRadius(12)
                                        .frame(width: 200, height: 320)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    MoviesView()
}
