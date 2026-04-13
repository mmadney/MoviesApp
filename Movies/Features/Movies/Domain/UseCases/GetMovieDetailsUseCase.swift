//
//  GetMovieDetailsUseCase.swift
//  Movies
//
//  Created by Madney on 13/04/2026.
//

import Foundation

protocol GetMovieDetailsUseCase {
    func execute(movieId: Int) async throws -> MovieDetails
}

class GetMovieDetailsUseCaseImp: GetMovieDetailsUseCase {
    private let repo: MoviesRepo

    init(repo: MoviesRepo) {
        self.repo = repo
    }

    func execute(movieId: Int) async throws -> MovieDetails {
        return try await repo.getMovieDetails(movieId: movieId)
    }
}


