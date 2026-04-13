//
//  MoviesRepo.swift
//  Movies
//
//  Created by Madney on 12/04/2026.
//

import Foundation

protocol MoviesRepo {
    func getGenres() async throws -> [Genre]
    func getMovies(page: Int, genreId: Int?) async throws -> [Movie]
    func getMovieDetails(movieId: Int) async throws -> MovieDetails
}
