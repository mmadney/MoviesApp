//
//  MoviesRepoImp.swift
//  Movies
//
//  Created by Madney on 12/04/2026.
//

import Foundation

final class MoviesRepoImp: MoviesRepo {
    private let remote: MoviesRemoteDataSource
    private let local: MoviesLocalDataSource

    init(remote: MoviesRemoteDataSource, local: MoviesLocalDataSource) {
        self.remote = remote
        self.local = local
    }

    func getGenres() async throws -> [Genre] {
        do {
            let remoteResponse = try await remote.getMovieGenre()
            local.saveGenres(remoteResponse)
            return local.getGenres()
        } catch {
            let cachedGenres = local.getGenres()
            if !cachedGenres.isEmpty {
                return cachedGenres
            }
            throw error
        }
    }

    func getMovies(page: Int, genreId: Int?) async throws -> [Movie] {
        do {
            let remoteResponse = try await remote.getMoviesList(
                page: page,
                genreId: genreId
            )
            local.saveMovies(remoteResponse, page: page, genreId: genreId)
            return local.getMovies(page: page, genreId: genreId)
        } catch {
            let cachedMovies = local.getMovies(page: page, genreId: genreId)
            if !cachedMovies.isEmpty {
                return cachedMovies
            }
            throw error
        }
    }
}
