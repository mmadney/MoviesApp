//
//  SearchMovieUseCase.swift
//  Movies
//
//  Created by Madney on 12/04/2026.
//

import Foundation

struct SearchMovieUseCase {
    func execute(movies: [Movie], query: String) -> [Movie] {
        let normalizedQuery = query
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        guard !normalizedQuery.isEmpty else {
            return movies
        }

        return movies.filter { movie in
            movie.title.lowercased().contains(normalizedQuery)
        }
    }
}
