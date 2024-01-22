//
//  RemoteImageMovie.swift
//  MoviesDemo
//
//  Created by Marco Alonso Rodriguez on 21/01/24.
//

import SwiftUI
import Kingfisher

struct RemoteImageMovie: View {
    var url: String
    
    var body: some View {
        KFImage(URL(string: "\(Constants.urlImages)\(url)"))
            .resizable()
            .placeholder { progress in
                ProgressView()
            }
    }
}
