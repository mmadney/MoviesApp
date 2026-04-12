//
//  MoviesLocalStore.swift
//  Movies
//
//  Created by Madney on 12/04/2026.
//

import Foundation

final class MoviesLocalStore: MoviesLocalDataSource {
    struct MoviesCacheKey: Hashable {
        let page: Int
        let genreId: Int?
    }

    private struct MoviesPageCache: Codable {
        let page: Int
        let genreId: Int?
        let movies: [Movie]
    }

    var genres: [Genre] = []
    var moviesByPage: [MoviesCacheKey: [Movie]] = [:]
    private let fileManager = FileManager.default
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init() {
        loadPersistedData()
    }

    func saveGenres(_ response: GenresResponseDTO) {
        genres = response.genres.map { $0.toDomain() }
        persistGenres()
    }

    func getGenres() -> [Genre] {
        return genres
    }

    func saveMovies(_ response: MoviesResponseDTO, page: Int, genreId: Int?) {
        let cacheKey = MoviesCacheKey(page: page, genreId: genreId)
        moviesByPage[cacheKey] = response.results.map { $0.toDomain() }
        persistMovies()
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

    private var cacheDirectoryURL: URL {
        let baseURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let directoryURL = baseURL.appendingPathComponent("MoviesCache", isDirectory: true)

        if !fileManager.fileExists(atPath: directoryURL.path) {
            try? fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true)
        }

        return directoryURL
    }

    private var genresFileURL: URL {
        cacheDirectoryURL.appendingPathComponent("genres.json")
    }

    private var moviesFileURL: URL {
        cacheDirectoryURL.appendingPathComponent("movies_by_page.json")
    }

    func persistGenres() {
        guard let data = try? encoder.encode(genres) else { return }
        try? data.write(to: genresFileURL, options: .atomic)
    }

    func persistMovies() {
        let flattened = moviesByPage.map { key, movies in
            MoviesPageCache(page: key.page, genreId: key.genreId, movies: movies)
        }

        guard let data = try? encoder.encode(flattened) else { return }
        try? data.write(to: moviesFileURL, options: .atomic)
    }

    private func loadPersistedData() {
        if let genresData = try? Data(contentsOf: genresFileURL),
           let decodedGenres = try? decoder.decode([Genre].self, from: genresData) {
            genres = decodedGenres
        }

        if let moviesData = try? Data(contentsOf: moviesFileURL),
           let decodedMovies = try? decoder.decode([MoviesPageCache].self, from: moviesData) {
            var cache: [MoviesCacheKey: [Movie]] = [:]
            for pageCache in decodedMovies {
                let key = MoviesCacheKey(page: pageCache.page, genreId: pageCache.genreId)
                cache[key] = pageCache.movies
            }
            moviesByPage = cache
        }
    }
}
