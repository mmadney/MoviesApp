//
//  MoviesLocalStorages.swift
//  Movies
//
//  Created by Madney on 12/04/2026.
//

import Foundation

protocol LocalStorages {
    func persistGenres(genres: [Genre])
    func persistMovies(moviesByPage: [MoviesCacheKey: [Movie]])
    func loadGenrePersistedData() -> [Genre]
    func loadMoviesPersistedData() -> [MoviesCacheKey: [Movie]]
}

class JsonLocalStorages: LocalStorages {
    private let fileManager = FileManager.default
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

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

    func persistGenres(genres: [Genre]) {
        guard let data = try? encoder.encode(genres) else { return }
        try? data.write(to: genresFileURL, options: .atomic)
    }

    func persistMovies(moviesByPage: [MoviesCacheKey: [Movie]]) {
        let flattened = moviesByPage.map { key, movies in
            MoviesPageCache(page: key.page, genreId: key.genreId, movies: movies)
        }
        guard let data = try? encoder.encode(flattened) else { return }
        try? data.write(to: moviesFileURL, options: .atomic)
    }

    func loadGenrePersistedData() -> [Genre] {
        if let genresData = try? Data(contentsOf: genresFileURL),
           let decodedGenres = try? decoder.decode([Genre].self, from: genresData) {
            return decodedGenres
        } else {
            return []
        }
    }

    func loadMoviesPersistedData() -> [MoviesCacheKey: [Movie]] {
        if let moviesData = try? Data(contentsOf: moviesFileURL),
           let decodedMovies = try? decoder.decode([MoviesPageCache].self, from: moviesData) {
            var cache: [MoviesCacheKey: [Movie]] = [:]
            for pageCache in decodedMovies {
                let key = MoviesCacheKey(page: pageCache.page, genreId: pageCache.genreId)
                cache[key] = pageCache.movies
            }
            return cache
        } else {
            return [:]
        }
    }
}
