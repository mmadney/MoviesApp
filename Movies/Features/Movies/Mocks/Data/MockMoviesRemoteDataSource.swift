//
//  MockMovieRemoteDataSource.swift
//  Movies
//
//  Created by Madney on 14/04/2026.
//

import Foundation

final class MockMoviesRemoteDataSource: MoviesRemoteDataSource {
    func getMovieGenre() async throws -> GenresResponseDTO {
        let data = JsonMock.genres.data(using: .utf8)!
        let response = try JSONDecoder().decode(GenresResponseDTO.self, from: data)
        return response
    }

    
    func getMoviesList(page: Int, genreId: Int?) async throws -> MoviesResponseDTO {
        let data = JsonMock.Movies.data(using: .utf8)!
        let response = try JSONDecoder().decode(MoviesResponseDTO.self, from: data)
        return response
    }

    func getMovieDetails(movieId: Int) async throws -> MovieDetailsDTO {
        let data = JsonMock.movieDetails.data(using: .utf8)!
        let response = try JSONDecoder().decode(MovieDetailsDTO.self, from: data)
        return response
    }
}
