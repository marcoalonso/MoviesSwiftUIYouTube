//
//  NetworkManager.swift
//  MoviesDemo
//
//  Created by Marco Alonso Rodriguez on 18/01/24.
//

import UIKit

enum APError: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
    case decodingError
}

class NetworkManager: NSObject {
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    static let upcoming = "https://api.themoviedb.org/3/movie/upcoming?api_key=2cfa8720256036601fb9ac4e4bce1a9b&language=es-MX&page=1"
    
    static let nowPlaying = "https://api.themoviedb.org/3/movie/now_playing?api_key=2cfa8720256036601fb9ac4e4bce1a9b&language=es-MX&page=1"
    
    static let trending = "https://api.themoviedb.org/3/trending/all/day?api_key=2cfa8720256036601fb9ac4e4bce1a9b"
    
    func getLisOfUpcomingMovies(completed: @escaping (Result<[DataMovie], APError>) -> Void ) {
        guard let url = URL(string: NetworkManager.upcoming) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
               let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MovieDataModel.self, from: data)
                completed(.success(decodedResponse.results))
            } catch {
                print("Debug: error \(error.localizedDescription)")
                completed(.failure(.decodingError))
            }
        }
        task.resume()
    }
    
    func getMoviesNowPlaying(completed: @escaping (Result<[DataMovie], APError>) -> Void ) {
        guard let url = URL(string: NetworkManager.nowPlaying) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
               let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MovieDataModel.self, from: data)
                completed(.success(decodedResponse.results))
            } catch {
                print("Debug: error \(error.localizedDescription)")
                completed(.failure(.decodingError))
            }
        }
        task.resume()
    }
    
    func getMoviesTrending(completed: @escaping (Result<[DataMovie], APError>) -> Void ) {
        guard let url = URL(string: NetworkManager.trending) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MovieDataModel.self, from: data)
                completed(.success(decodedResponse.results))
            } catch {
                print("Debug: decoding error \(error.localizedDescription)")
                completed(.failure(.decodingError))
            }
        }
        task.resume()
    }
    
    func getListOfTrailers(id: Int, completed: @escaping (Result<[Trailer], APError>) -> Void ) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=2cfa8720256036601fb9ac4e4bce1a9b&language=es_MX") else {
            completed(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
             let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(TrailerResponse.self, from: data)
                completed(.success(decodedResponse.results))
            } catch {
                print("Debug: error \(error.localizedDescription)")
                completed(.failure(.decodingError))
            }
        }
        task.resume()
        
    }
    
    func searchMovies(name: String, completed: @escaping (Result<[DataMovie], APError>) -> Void ) {
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=2cfa8720256036601fb9ac4e4bce1a9b&language=es-MX&page=1&include_adult=false&query=\(name)") else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
             let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MovieDataModel.self, from: data)
                completed(.success(decodedResponse.results))
            } catch {
                print("Debug: error \(error.localizedDescription)")
                completed(.failure(.decodingError))
            }
        }
        task.resume()
    }
    
}


struct Constants {
    static let urlImages = "https://image.tmdb.org/t/p/original"
    static let placeholder = "https://cringemdb.com/img/movie-poster-placeholder.png"
    static let urlTrailer = "uxRm9UiJ0PY&t=12s"
}
