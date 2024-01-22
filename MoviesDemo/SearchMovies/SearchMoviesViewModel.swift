//
//  SearchMoviesViewModel.swift
//  MoviesDemo
//
//  Created by Marco Alonso Rodriguez on 21/01/24.
//

import Foundation

class SearchMoviesViewModel: ObservableObject {
    @Published var moviesFounded: [DataMovie] = []
    
    func searchMovie(name: String) {
        NetworkManager.shared.searchMovies(name: name) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                switch result {
                case .success(let movies):
                    self.moviesFounded = movies
                case .failure(let error):
                    print("error \(error)")
                }
            }
        }
    }
}
