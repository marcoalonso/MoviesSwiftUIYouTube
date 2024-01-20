//
//  TrailerModel.swift
//  MoviesDemo
//
//  Created by Marco Alonso Rodriguez on 20/01/24.
//

import Foundation

struct TrailerResponse: Codable {
    let id: Int
    let results: [Trailer]
}

struct Trailer: Codable {
    let key: String
    let name: String
    let type: String
    let published_at: String
}
