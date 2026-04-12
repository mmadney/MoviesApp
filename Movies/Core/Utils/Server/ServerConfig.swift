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


class ServerConfig {
    static let shared: ServerConfig = ServerConfig()
    
    var baseUrl: String

    init() {
        baseUrl = Base_Url.test.rawValue
    }

    func setupServerConfig() {
        baseUrl = Base_Url.test.rawValue
    }
}
