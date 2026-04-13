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
    private let sut = SearchMovieUseCaseImp()

    private let movies = MovieMocks.sample

    @Test func execute_withEmptyString_returnsAllMovies() {
        let result = sut.execute(movies: movies, query: "")
        #expect(result.count == movies.count)
    }

    @Test func execute_withWhitespaceOnly_returnsAllMovies() {
        let result = sut.execute(movies: movies, query: "   \n\t  ")
        #expect(result.count == movies.count)
    }

    @Test func execute_filtersCaseInsensitively() {
        let result = sut.execute(movies: movies, query: "ENCANTO")
        #expect(result.count == 1)
        #expect(result.first?.title == "Encanto")
    }

    @Test func execute_matchesSubstringInTitle() {
        let result = sut.execute(movies: movies, query: "empire")
        #expect(result.count == 1)
        #expect(result.first?.id == 1891)
    }

    @Test func execute_withNoMatches_returnsEmpty() {
        let result = sut.execute(movies: movies, query: "zzzz-not-found")
        #expect(result.isEmpty)
    }

    @Test func execute_trimsLeadingAndTrailingWhitespace() {
        let result = sut.execute(movies: movies, query: "  star  ")
        #expect(result.count == 1)
        #expect(result.first?.title == "Star Wars")
    }
}
