//
//  GetMoviesUseCase.swift
//  Movies
//
//  Created by Madney on 12/04/2026.
//

import Foundation

struct GetMoviesUseCase {
    private let repo: MoviesRepo

    init(repo: MoviesRepo) {
        self.repo = repo
    }

    func execute(page: Int, genreId: Int?) async throws -> [Movie] {
        return try await repo.getMovies(page: page, genreId: genreId)
    }
}
