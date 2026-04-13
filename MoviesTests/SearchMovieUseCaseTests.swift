//
//  SearchMovieUseCaseTests.swift
//  MoviesTests
//
//  Created by Madney on 13/04/2026.
//

import Testing
@testable import Movies

struct SearchMovieUseCaseTests {
    private let sut = SearchMovieUseCase()

    private func sampleMovies() -> [Movie] {
        [
            Movie(id: 1, title: "Star Wars", releaseDate: "1977-05-25", poster: nil, genreIds: [12]),
            Movie(id: 2, title: "Encanto", releaseDate: "2021-11-24", poster: nil, genreIds: [16]),
            Movie(id: 3, title: "The Empire Strikes Back", releaseDate: "1980-05-21", poster: nil, genreIds: [12]),
        ]
    }

    @Test func execute_withEmptyString_returnsAllMovies() {
        let movies = sampleMovies()
        let result = sut.execute(movies: movies, query: "")
        #expect(result.count == movies.count)
    }

    @Test func execute_withWhitespaceOnly_returnsAllMovies() {
        let movies = sampleMovies()
        let result = sut.execute(movies: movies, query: "   \n\t  ")
        #expect(result.count == movies.count)
    }

    @Test func execute_filtersCaseInsensitively() {
        let movies = sampleMovies()
        let result = sut.execute(movies: movies, query: "ENCANTO")
        #expect(result.count == 1)
        #expect(result.first?.title == "Encanto")
    }

    @Test func execute_matchesSubstringInTitle() {
        let movies = sampleMovies()
        let result = sut.execute(movies: movies, query: "empire")
        #expect(result.count == 1)
        #expect(result.first?.id == 3)
    }

    @Test func execute_withNoMatches_returnsEmpty() {
        let movies = sampleMovies()
        let result = sut.execute(movies: movies, query: "zzzz-not-found")
        #expect(result.isEmpty)
    }

    @Test func execute_trimsLeadingAndTrailingWhitespace() {
        let movies = sampleMovies()
        let result = sut.execute(movies: movies, query: "  star  ")
        #expect(result.count == 1)
        #expect(result.first?.title == "Star Wars")
    }
}
