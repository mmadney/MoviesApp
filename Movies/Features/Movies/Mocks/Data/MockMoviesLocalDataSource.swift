//
//  MockMoviesLocalDataSource.swift
//  Movies
//
//  Created by Madney on 14/04/2026.
//

import Foundation

class MockMoviesLocalDataSource: MoviesLocalDataSource {
    var genres: [Genre] = []
    var moviesByPage: [MoviesCacheKey: [Movie]] = [:]

    func saveGenres(_ response: GenresResponseDTO) {
        genres = response.genres.map { $0.toDomain() }
    }

    func getGenres() -> [Genre] {
        return genres
    }

    func saveMovies(_ response: MoviesResponseDTO, page: Int, genreId: Int?) {
        let cacheKey = MoviesCacheKey(page: page, genreId: genreId)
        moviesByPage[cacheKey] = response.results.map { $0.toDomain() }
    }

    func getMovies(page: Int, genreId: Int?) -> [Movie] {
        let cacheKey = MoviesCacheKey(page: page, genreId: genreId)
        if let movies = moviesByPage[cacheKey] {
            return movies
        } else {
            return []
        }
    }

    func searchMoviesByGenre(genreId: Int?) -> [Movie] {
        if let genreId {
            return moviesByPage.values.flatMap { $0 }.filter { $0.genreIds.contains(genreId) }
        } else {
            return []
        }
    }
}
