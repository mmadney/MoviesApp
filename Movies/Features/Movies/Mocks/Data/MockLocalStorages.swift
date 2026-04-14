//
//  MockLocalStorages.swift
//  Movies
//
//  Created by Madney on 13/04/2026.
//

import Foundation


class MockLocalStorages: LocalStorages {
    var genresPersisted: [Genre] = []
    var moviesPersisted: [MoviesCacheKey: [Movie]] = [:]
    
    func loadGenrePersistedData() -> [Genre] {
        return genresPersisted
    }
    
    func persistGenres(genres: [Genre]) {
        genresPersisted = genres
    }
    
    func loadMoviesPersistedData() -> [MoviesCacheKey: [Movie]] {
        return moviesPersisted
    }
    
    func persistMovies(moviesByPage: [MoviesCacheKey: [Movie]]) {
        moviesPersisted = moviesByPage
    }
}
