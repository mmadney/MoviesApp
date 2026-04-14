//
//  SearchMovieUseCaseTests.swift
//  MoviesTests
//
//  Created by Madney on 13/04/2026.
//

@testable import Movies
import Testing

@MainActor
struct SearchMovieUseCaseTests {

    private func sampleMovies() -> [Movie] {
        MovieMocks.sample
    }

    @Test @MainActor
    func execute_withEmptyString_returnsAllMovies() {
        let sut = SearchMovieUseCaseImp()
        let movies = sampleMovies()
        let result = sut.execute(movies: movies, query: "")
        #expect(result.count == movies.count)
    }

    @Test @MainActor
    func execute_withWhitespaceOnly_returnsAllMovies() {
        let sut = SearchMovieUseCaseImp()
        let movies = sampleMovies()
        let result = sut.execute(movies: movies, query: "   \n\t  ")
        #expect(result.count == movies.count)
    }

    @Test @MainActor
    func execute_filtersCaseInsensitively() {
        let sut = SearchMovieUseCaseImp()
        let movies = sampleMovies()
        let result = sut.execute(movies: movies, query: "ENCANTO")
        #expect(result.count == 1)
        #expect(result.first?.title == "Encanto")
    }

    @Test @MainActor
    func execute_matchesSubstringInTitle() {
        let sut = SearchMovieUseCaseImp()
        let movies = sampleMovies()
        let result = sut.execute(movies: movies, query: "empire")
        #expect(result.count == 1)
        #expect(result.first?.id == 1891)
    }

    @Test @MainActor
    func execute_withNoMatches_returnsEmpty() {
        let sut = SearchMovieUseCaseImp()
        let movies = sampleMovies()
        let result = sut.execute(movies: movies, query: "zzzz-not-found")
        #expect(result.isEmpty)
    }

    @Test @MainActor
    func execute_trimsLeadingAndTrailingWhitespace() {
        let sut = SearchMovieUseCaseImp()
        let movies = sampleMovies()
        let result = sut.execute(movies: movies, query: "  star  ")
        #expect(result.count == 1)
        #expect(result.first?.title == "Star Wars")
    }
}
