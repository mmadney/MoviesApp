//
//  MoviesListApiRequests.swift
//  Movies
//
//  Created by Madney on 12/04/2026.
//

import Foundation

enum MoviesListApiRequests {
    case getMoviesGenre
    case getMoviesList
}

extension MoviesListApiRequests: Endpoint {
    var base: String {
        return ServerConfig.shared.baseUrl
    }

    var requestType: RequestType {
        switch self {
        case .getMoviesGenre:
            return .GET
        case .getMoviesList:
            return .GET
        }
    }

    var paramter: [String: Any]? {
        switch self {
        case .getMoviesGenre:
            return nil
        case .getMoviesList:
            return nil
        }
    }

    var path: String {
        switch self {
        case .getMoviesGenre:
            return ServerPaths.gnereMoviesList
        case .getMoviesList:
            return ServerPaths.movieDetails + "&page=\(page)"
        }
    }
}
