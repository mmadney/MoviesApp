//
//  MoviesListApiRequests.swift
//  Movies
//
//  Created by Madney on 12/04/2026.
//

import Foundation

enum MoviesApiRequests {
    case getMoviesGenre
    case getMoviesList(page: Int, withGenre: Int?)
}

extension MoviesApiRequests: Endpoint {
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
        case let .getMoviesList(page, withGenre):
            var path = "\(ServerPaths.movieList)?page=\(page)"
            if let withGenre {
                path += "&with_genres=\(withGenre)"
            }
            return path
        }
    }
}
