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

@MainActor
struct MoviesListViewModelTests {
    @Test func testLoaded() async {
        registerSuccessMocks()
        let sut = MoviesListViewModel()
        await sut.onAppear()

        #expect(sut.errorMessage == nil)
        #expect(sut.isLoading == false)
        #expect(sut.genres.map(\.id) == GenreMocks.sample.map(\.id))
        #expect(sut.visibleMovies.map(\.id) == MovieMocks.sample.map(\.id))
    }

    @Test func testSelectGenre() async {
        registerSuccessMocks()
        let sut = MoviesListViewModel()

        await sut.selectGenre(12)

        #expect(sut.selectedGenreId == 12)
        #expect(sut.visibleMovies.count == 2)
    }

    @Test func testEmptyMovies() async {
        registerMocksWithSomeParamtersMovieUseCase(
            movies: [],
            endsAfterFirstPage: true,
            filterByGenreId: true
        )

        let model = MoviesListViewModel()
        await model.onAppear()

        #expect(model.errorMessage == nil)
        #expect(model.visibleMovies.isEmpty)
        #expect(model.genres.isEmpty == false)
    }

    @Test func testErrors() async {
        registerMocksWithSomeParamtersGenreUseCase(result: .failure(
            NSError(
                domain: "MoviesTests",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Some Error"]
            )
        ))

        let model = MoviesListViewModel()
        await model.onAppear()

        #expect(model.errorMessage == "Some Error")
        #expect(model.visibleMovies.isEmpty)
    }

    @Test func testSearchFiltersVisibleMovies() async {
        registerSuccessMocks()
        let model = MoviesListViewModel()
        await model.onAppear()

        model.searchText = "Encanto"

        #expect(model.visibleMovies.count == 1)
        #expect(model.visibleMovies.first?.title == "Encanto")
    }
}

private func registerSuccessMocks() {
    Container.shared.getGeneresUseCase.register { @MainActor in
        MockGetGenresUseCase()
    }
    
    Container.shared.getMoviesUseCase.register { @MainActor in
        MockGetMoviesUseCase()
    }
    
    Container.shared.searchMovieUseCase.register { @MainActor in
        MockSearchMovieUseCase()
    }
}

private func registerMocksWithSomeParamtersGenreUseCase(result: Result<[Genre], Error>) {
    Container.shared.getGeneresUseCase.register { @MainActor in
        MockGetGenresUseCase(result: result)
    }

    Container.shared.getMoviesUseCase.register { @MainActor in
        MockGetMoviesUseCase()
    }

    Container.shared.searchMovieUseCase.register { @MainActor in
        MockSearchMovieUseCase()
    }
}

private func registerMocksWithSomeParamtersMovieUseCase(movies: [Movie],
                                                        endsAfterFirstPage: Bool,
                                                        filterByGenreId: Bool) {
    Container.shared.getGeneresUseCase.register { @MainActor in
        MockGetGenresUseCase()
    }

    Container.shared.getMoviesUseCase.register { @MainActor in
        MockGetMoviesUseCase(movies: movies,
                             endsAfterFirstPage: endsAfterFirstPage,
                             filterByGenreId: filterByGenreId)
    }

    Container.shared.searchMovieUseCase.register { @MainActor in
        MockSearchMovieUseCase()
    }
}
