//
//  MoviesListRemote.swift
//  Movies
//
//  Created by Madney on 12/04/2026.
//

import Foundation

protocol MoviesRemoteDataSource {
    func getMovieGenre() async throws -> GenresResponseDTO
    func getMoviesList(
        page: Int,
        genreId: Int?
    ) async throws -> MoviesResponseDTO
    func getMovieDetails(movieId: Int) async throws -> MovieDetailsDTO
}

final class MoviesRemote: NetworkApi, MoviesRemoteDataSource {
    var session: URLSession

    init() {
        session = URLSession(configuration: .default)
    }

    func getMovieGenre() async throws -> GenresResponseDTO {
        return try await fetch(
            type: GenresResponseDTO.self,
            with: MoviesApiRequests.getMoviesGenre
        )
    }

    func getMoviesList(
        page: Int,
        genreId: Int?
    ) async throws -> MoviesResponseDTO {
        return try await fetch(
            type: MoviesResponseDTO.self,
            with: MoviesApiRequests.getMoviesList(
                page: page,
                withGenre: genreId
            )
        )
    }

    func getMovieDetails(movieId: Int) async throws -> MovieDetailsDTO {
        return try await fetch(
            type: MovieDetailsDTO.self,
            with: MoviesApiRequests.getMovieDetails(movieId: movieId)
        )
    }
}
