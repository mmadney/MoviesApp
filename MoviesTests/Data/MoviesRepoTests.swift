//
//  MoviesRepoTests.swift
//  MoviesTests
//
//  Created by Madney on 14/04/2026.
//

@testable import Movies
import Testing

@MainActor
struct MoviesRepoTests {
    private let remoteMock = MockMoviesRemoteDataSource()
    private let localMock = MockMoviesLocalDataSource()

    @Test func testGetGeneresFromLocal() async throws {
        // given
        let repo = MoviesRepoImp(remote: remoteMock, local: localMock)

        // when
        let genres = try await repo.getGenres()

        // then
        #expect(genres.count == localMock.genres.count)
    }

    @Test func testGetMoviesFromLocal() async throws {
        // given
        let repo = MoviesRepoImp(remote: remoteMock, local: localMock)

        // when
        let movies = try await repo.getMovies(page: 1, genreId: 18)

        // then
        let cacheKey = MoviesCacheKey(page: 1, genreId: 18)
        let expectedMovies = localMock.moviesByPage[cacheKey] ?? []
        #expect(movies.count == expectedMovies.count)
    }

    @Test func testGetMovieswithNoGenId() async throws {
        // given
        let repo = MoviesRepoImp(remote: remoteMock, local: localMock)

        // when
        let movies = try await repo.getMovies(page: 1, genreId: nil)

        // then
        let cacheKey = MoviesCacheKey(page: 1, genreId: nil)
        let expectedMovies = localMock.moviesByPage[cacheKey] ?? []
        #expect(movies.count == expectedMovies.count)
    }
}
