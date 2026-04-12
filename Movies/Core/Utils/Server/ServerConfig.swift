//
//  ServerConfig.swift
//  Movies
//
//  Created by Madney on 12/04/2026.
//

import Foundation

enum Base_Url: String {
    case test = "https://api.themoviedb.org/3"
}

enum Poster_Base_Url: String {
    case test = "https://image.tmdb.org/t/p/w500"
}


class ServerConfig {
    static let shared: ServerConfig = ServerConfig()
    
    var baseUrl: String
    var posterBaseUrl: String
        

    init() {
        baseUrl = Base_Url.test.rawValue
        posterBaseUrl = Poster_Base_Url.test.rawValue
    }

    func setupServerConfig() {
        baseUrl = Base_Url.test.rawValue
        posterBaseUrl = Poster_Base_Url.test.rawValue
    }
}
