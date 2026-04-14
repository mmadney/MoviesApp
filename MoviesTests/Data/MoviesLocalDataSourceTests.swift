//
//  MoviesLocalDataSourceTests.swift
//  MoviesTests
//
//  Created by Madney on 13/04/2026.
//

import Foundation
import Testing

@testable import Movies

@MainActor
struct MoviesLocalDataSourceTests {
    @Test func saveGenres_mapsDTOToDomainAndPersists() throws {
        let storage = MockLocalStorages()
        let local = MoviesLocal(localStorage: storage)
        let data = try #require(JsonMock.genres.data(using: .utf8))
        let dto = try JSONDecoder().decode(GenresResponseDTO.self, from: data)

        local.saveGenres(dto)

        #expect(local.getGenres().count == 2)
        #expect(local.getGenres().map(\.name) == ["Action", "Adventure"])
        #expect(storage.genresPersisted.count == 2)
    }

    @Test func saveMovies_storesPageAndGenreKey() throws {
        let storage = MockLocalStorages()
        let local = MoviesLocal(localStorage: storage)
        let data = try #require(JsonMock.Movies.data(using: .utf8))
        let response = try JSONDecoder().decode(MoviesResponseDTO.self, from: data)

        local.saveMovies(response, page: 1, genreId: 18)

        let key = MoviesCacheKey(page: 1, genreId: 18)
        #expect(local.getMovies(page: 1, genreId: 18).count == 2)
        #expect(local.getMovies(page: 1, genreId: 18).first?.id == 1523145)
        #expect(storage.moviesPersisted[key]?.count == 2)
    }

    @Test func getMovies_whenMissingGenreKey_filtersUnfilteredPageByGenre() throws {
        let storage = MockLocalStorages()
        let local = MoviesLocal(localStorage: storage)
        let data = try #require(JsonMock.Movies.data(using: .utf8))
        let response = try JSONDecoder().decode(MoviesResponseDTO.self, from: data)

        local.saveMovies(response, page: 1, genreId: nil)

        let filtered = local.getMovies(page: 1, genreId: 12)
        #expect(filtered.count == 1)
        #expect(filtered.first?.id == 1226863)
        
    }
    
    @Test func getMovies_whenMissingGenreKey_returnAllMoviesPerPage() throws {
        let storage = MockLocalStorages()
        let local = MoviesLocal(localStorage: storage)
        let data = try #require(JsonMock.Movies.data(using: .utf8))
        let response = try JSONDecoder().decode(MoviesResponseDTO.self, from: data)

        local.saveMovies(response, page: 1, genreId: nil)
        
        let all = local.getMovies(page: 1, genreId: nil)
        #expect(all.count == 2)
        
    }

    @Test func searchMoviesByGenre_deduplicatesAndSortsById() throws {
        let storage = MockLocalStorages()
        let local = MoviesLocal(localStorage: storage)

        let data = try #require(JsonMock.singleMovieJSON.data(using: .utf8))
        let response = try JSONDecoder().decode(MoviesResponseDTO.self, from: data)

        local.saveMovies(response, page: 1, genreId: nil)
        local.saveMovies(response, page: 2, genreId: nil)

        let movies = local.searchMoviesByGenre(genreId: nil)
        #expect(movies.count == 1)

        let actionOnly = local.searchMoviesByGenre(genreId: 28)
        #expect(actionOnly.count == 1)
        #expect(actionOnly.first?.id == 5)
    }
}
