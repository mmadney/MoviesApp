//
//  GetGenresUseCase.swift
//  Movies
//
//  Created by Madney on 12/04/2026.
//

import Foundation

protocol GetGenresUseCase {
    func execute() async throws -> [Genre]
}

class GetGenresUseCaseImp: GetGenresUseCase {
    private let repo: MoviesRepo

    init(repo: MoviesRepo) {
        self.repo = repo
    }

    func execute() async throws -> [Genre] {
        return try await repo.getGenres()
    }
}



