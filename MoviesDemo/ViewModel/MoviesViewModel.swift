//
//  MoviesViewModel.swift
//  MoviesDemo
//
//  Created by Marco Alonso Rodriguez on 18/01/24.
//

import Foundation

class MoviesViewModel: ObservableObject {
    @Published var upcomingMovies: [DataMovie] = []
    @Published var nowPlayingMovies: [DataMovie] = []
    @Published var trendingMovies: [DataMovie] = []
    
    
    init() {
        getListOfUpcomingMovies()
        getMoviesNowPlaying()
        getMoviesTrending()
    }
    
    func getListOfUpcomingMovies() {
        NetworkManager.shared.getLisOfUpcomingMovies { [weak self] result in
            DispatchQueue.main.async {
                
                guard let self else { return }
                switch result {
                case .success(let movies):
                    self.upcomingMovies = movies
                    
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        print("Error invalidURL")
                    case .unableToComplete:
                        print("Error unableToComplete")
                    case .invalidResponse:
                        print("Error invalidResponse")
                    case .invalidData:
                        print("Error invalidData")
                    case .decodingError:
                        print("Error decodingError")
                    }
                }
            }
        }
    }
    
    func getMoviesNowPlaying() {
        NetworkManager.shared.getMoviesNowPlaying { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.nowPlayingMovies = movies
                    
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        print("Error invalidURL")
                    case .unableToComplete:
                        print("Error unableToComplete")
                    case .invalidResponse:
                        print("Error invalidResponse")
                    case .invalidData:
                        print("Error invalidData")
                    case .decodingError:
                        print("Error decodingError")
                    }
                }
            }
        }
    }
    
    func getMoviesTrending() {
        NetworkManager.shared.getMoviesTrending() { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                switch result {
                case .success(let movies):
                    self.trendingMovies = movies
                    
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        // self.alertItem = AlertContext.invalidURL
                        print("Error")
                        
                    case .decodingError:
                        // self.alertItem = AlertContext.decodingError
                        print("Error")
                    case .invalidData:
                        // self.alertItem = AlertContext.invalidData
                        print("Error")
                    case .invalidResponse:
                        // self.alertItem = AlertContext.invalidResponse
                        print("Error")
                    case .unableToComplete:
                        // self.alertItem = AlertContext.unableToComplete
                        print("Error")
                    }
                }
            }
        }
    }
}
