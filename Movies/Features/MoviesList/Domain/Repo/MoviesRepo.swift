//
//  MoviesRepo.swift
//  Movies
//
//  Created by Madney on 12/04/2026.
//

import Foundation

protocol MoviesRepo {
    func getGenres() async throws -> [Genre]
    func getMovies() async throws -> [Movie]
}
