//
//  MoviesRepoImp.swift
//  Movies
//
//  Created by Madney on 12/04/2026.
//

import Foundation

final class MoviesRepoImp: MoviesRepo {
    private let remote : MoviesRemoteDataSource
    
    init(remote: MoviesRemoteDataSource) {
        self.remote = remote
    }
    
    
    func getGenres() async throws -> [Genre] {
        
    }

    func getMovies() async throws -> [Movie] {
        
    }
}
