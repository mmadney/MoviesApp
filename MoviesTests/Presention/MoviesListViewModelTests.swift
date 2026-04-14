//
//  MoviesListViewModelTests.swift
//  MoviesTests
//
//  Created by Madney on 13/04/2026.
//

import Factory
import FactoryTesting
import Foundation
import Testing

@testable import Movies

struct MoviesListViewModelTests {

    func testLoaded() async {
        registerSuccessMocks()
        let model = MoviesListViewModel()
        await model.onAppear()

        #expect(model.errorMessage == nil)
        #expect(model.isLoading == false)
        #expect(model.genres.map(\.id) == GenreMocks.sample.map(\.id))
        #expect(model.visibleMovies.map(\.id) == MovieMocks.sample.map(\.id))
    }

    @Test @MainActor
    func testEmptyMovies() async {
        Container.shared.getGeneresUseCase.register { GenresSuccessStub() }
        Container.shared.getMoviesUseCase.register {
            MoviesPageStub(movies: [], endsAfterFirstPage: true, filterByGenreId: true)
        }
        Container.shared.searchMovieUseCase.register { SearchFilterStub() }

        let model = MoviesListViewModel()
        await model.onAppear()

        #expect(model.errorMessage == nil)
        #expect(model.visibleMovies.isEmpty)
        #expect(model.genres.isEmpty == false)
    }

    @Test @MainActor
    func testErrors() async {
        Container.shared.getGeneresUseCase.register { GenresThrowingStub() }
        Container.shared.getMoviesUseCase.register { MoviesPageStub.sample() }
        Container.shared.searchMovieUseCase.register { SearchFilterStub() }

        let model = MoviesListViewModel()
        await model.onAppear()

        #expect(model.errorMessage == "Some Error")
        #expect(model.visibleMovies.isEmpty)
    }

    @Test @MainActor
    func testSearchFiltersVisibleMovies() async {
        registerSuccessMocks()
        let model = MoviesListViewModel()
        await model.onAppear()

        model.searchText = "Encanto"

        #expect(model.visibleMovies.count == 1)
        #expect(model.visibleMovies.first?.title == "Encanto")
    }
}

private func registerSuccessMocks() {
    Container.shared.getGeneresUseCase.register { GenresSuccessStub() }
    Container.shared.getMoviesUseCase.register { MoviesPageStub.sample() }
    Container.shared.searchMovieUseCase.register { SearchFilterStub() }
}

private struct GenresSuccessStub: GetGenresUseCase {
    func execute() async throws -> [Genre] {
        GenreMocks.sample
    }
}

private struct GenresThrowingStub: GetGenresUseCase {
    func execute() async throws -> [Genre] {
        throw NSError(
            domain: "MoviesTests",
            code: 1,
            userInfo: [NSLocalizedDescriptionKey: "Some Error"]
        )
    }
}

private struct MoviesPageStub: GetMoviesUseCase {
    let movies: [Movie]
    let endsAfterFirstPage: Bool
    let filterByGenreId: Bool

    static func sample() -> MoviesPageStub {
        MoviesPageStub(
            movies: MovieMocks.sample,
            endsAfterFirstPage: true,
            filterByGenreId: true
        )
    }

    func execute(page: Int, genreId: Int?) async throws -> [Movie] {
        if endsAfterFirstPage && page > 1 {
            return []
        }
        var result = movies
        if filterByGenreId, let genreId {
            result = result.filter { $0.genreIds.contains(genreId) }
        }
        return result
    }
}

private struct SearchFilterStub: SearchMovieUseCase {
    func execute(movies: [Movie], query: String) -> [Movie] {
        let normalizedQuery = query
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        guard !normalizedQuery.isEmpty else {
            return movies
        }

        return movies.filter { movie in
            movie.title.lowercased().contains(normalizedQuery)
        }
    }
}
