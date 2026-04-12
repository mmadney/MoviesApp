//
//  GetUniqueMoviesUseCase.swift
//  Movies
//
//  Created by Madney on 12/04/2026.
//

import Foundation

struct GetUniqueMoviesUseCase {
    func execute(_ movies: [Movie]) -> [Movie] {
        var map: [Int: Movie] = [:]
        for movie in movies {
            map[movie.id] = movie
        }
        return map.values.sorted(by: { $0.id < $1.id })
    }
}
