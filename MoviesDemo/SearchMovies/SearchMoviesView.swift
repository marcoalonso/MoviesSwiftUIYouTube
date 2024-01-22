//
//  SearchMoviesView.swift
//  MoviesDemo
//
//  Created by Marco Alonso Rodriguez on 21/01/24.
//

import SwiftUI
import Kingfisher

struct SearchMoviesView: View {
    @State private var nameOfMovie = ""
    @StateObject var viewModel = SearchMoviesViewModel()
    
    private let fixedColums = [
        GridItem(.fixed(150)),
        GridItem(.fixed(150))
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: fixedColums, spacing: 20) {
                        ForEach(viewModel.moviesFounded, id: \.id) { movie in
                            NavigationLink {
                                MovieDetailView(movie: movie)
                            } label: {
                                VStack {
                                    KFImage(URL(string: "\(Constants.urlImages)\(movie.poster_path ?? "")"))
                                        .resizable()
                                        .placeholder { progress in
                                            ProgressView()
                                        }
                                        .cornerRadius(12)
                                }
                                .frame(width: 150, height: 200)
                            }
                        }
                    }
                }
                .padding(12)
            }
            .navigationTitle("Search Movies")
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .searchable(text: $nameOfMovie, prompt: "Nombre de la pelicula")
            .onChange(of: nameOfMovie) { oldValue, newValue in
                viewModel.searchMovie(name: newValue)
            }
        }
    }
}

#Preview {
    SearchMoviesView()
}
