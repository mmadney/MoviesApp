//
//  MoviesListRemote.swift
//  Movies
//
//  Created by Madney on 12/04/2026.
//

import Foundation

protocol MoviesRemoteDataSource {
    func getMovieGenre() async throws -> GenresResponseDTO
    func getMoviesList() async throws -> MoviesResponseDTO
}

final class MoviesListRemote: NetworkApi, MoviesRemoteDataSource {
    var session: URLSession

    init() {
        session = URLSession(configuration: .default)
    }

    func getMovieGenre() async throws -> GenresResponseDTO {
        return try await fetch(
            type: GenresResponseDTO.self,
            with: MoviesListApiRequests.getMoviesGenre
        )
    }

    func getMoviesList() async throws -> MoviesResponseDTO {
        return try await fetch(
            type: MoviesResponseDTO.self,
            with: MoviesListApiRequests.getMoviesList
        )
    }
}
