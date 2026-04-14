//
//  MockGetMoviesUseCase.swift
//  Movies
//
//  Created by Madney on 14/04/2026.
//

import Foundation

struct MockGetMoviesUseCase: GetMoviesUseCase {
    let movies: [Movie]
    let endsAfterFirstPage: Bool
    let filterByGenreId: Bool

    init(
        movies: [Movie] = MovieMocks.sample,
        endsAfterFirstPage: Bool = true,
        filterByGenreId: Bool = true
    ) {
        self.movies = movies
        self.endsAfterFirstPage = endsAfterFirstPage
        self.filterByGenreId = filterByGenreId
    }

    func execute(page: Int, genreId: Int?) async throws -> [Movie] {
        if endsAfterFirstPage && page > 1 {
            return []
        }

        guard filterByGenreId, let genreId else {
            return movies
        }

        return movies.filter { $0.genreIds.contains(genreId) }
    }
}
