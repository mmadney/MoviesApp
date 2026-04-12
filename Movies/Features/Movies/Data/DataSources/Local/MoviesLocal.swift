//
//  MoviesLocalStore.swift
//  Movies
//
//  Created by Madney on 12/04/2026.
//

import Foundation

struct MoviesCacheKey: Hashable {
    let page: Int
    let genreId: Int?
}

struct MoviesPageCache: Codable {
    let page: Int
    let genreId: Int?
    let movies: [Movie]
}

final class MoviesLocal: MoviesLocalDataSource {
    var genres: [Genre] = []
    var moviesByPage: [MoviesCacheKey: [Movie]] = [:]
    var localStorage: LocalStorages

    init(localStorage: LocalStorages) {
        self.localStorage = localStorage
        genres = localStorage.loadGenrePersistedData()
        moviesByPage = localStorage.loadMoviesPersistedData()
    }

    func saveGenres(_ response: GenresResponseDTO) {
        genres = response.genres.map { $0.toDomain() }
        localStorage.persistGenres(genres: genres)
    }

    func getGenres() -> [Genre] {
        return genres
    }

    func saveMovies(_ response: MoviesResponseDTO, page: Int, genreId: Int?) {
        let cacheKey = MoviesCacheKey(page: page, genreId: genreId)
        moviesByPage[cacheKey] = response.results.map { $0.toDomain() }
        localStorage.persistMovies(moviesByPage: moviesByPage)
    }

    func getMovies(page: Int, genreId: Int?) -> [Movie] {
        let cacheKey = MoviesCacheKey(page: page, genreId: genreId)

        if let movies = moviesByPage[cacheKey] {
            return movies
        }

        if let genreId,
           let unfilteredPageMovies = moviesByPage[MoviesCacheKey(page: page, genreId: nil)] {
            return unfilteredPageMovies
                .filter { $0.genreIds.contains(genreId) }
        }

        return []
    }

    func searchMoviesByGenre(genreId: Int?) -> [Movie] {
        let allCachedMovies = moviesByPage.values.flatMap { $0 }

        let filteredMovies: [Movie]
        if let genreId {
            filteredMovies = allCachedMovies.filter { $0.genreIds.contains(genreId) }
        } else {
            filteredMovies = allCachedMovies
        }

        var uniqueMoviesById: [Int: Movie] = [:]
        for movie in filteredMovies {
            uniqueMoviesById[movie.id] = movie
        }

        return uniqueMoviesById.values
            .sorted(by: { $0.id < $1.id })
    }
}
