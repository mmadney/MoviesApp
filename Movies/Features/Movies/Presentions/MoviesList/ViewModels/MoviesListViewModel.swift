//
//  MoviesListViewModel.swift
//  Movies
//
//  Created by Madney on 12/04/2026.
//

import Foundation
import Combine
import Factory

@MainActor
final class MoviesListViewModel: ObservableObject {
    @Published var searchText: String = "" {
        didSet {
            applyFilters()
        }
    }
    @Published private(set) var genres: [Genre] = []
    @Published private(set) var selectedGenreId: Int? = nil
    @Published private(set) var visibleMovies: [Movie] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?

    @LazyInjected(\.getGeneresUseCase) var getGenresUseCase
    @LazyInjected(\.getMoviesUseCase) var getMoviesUseCase
    @LazyInjected(\.getUniqueMoviesUseCase) var getUniqueMoviesUseCase
    @LazyInjected(\.searchMovieUseCase) var searchMovieUseCase

   
    private var loadedMovies: [Movie] = []
    private var currentPage: Int = 1
    private var hasLoadedOnce = false
    private var hasMorePages = true
    

    func onAppear() async {
        guard !hasLoadedOnce else { return }
        hasLoadedOnce = true
        await loadInitialData()
    }

    func selectGenre(_ genreId: Int?) async {
        guard selectedGenreId != genreId else { return }
        selectedGenreId = genreId
        await resetAndReloadMovies()
    }

    func loadNextPageIfNeeded(currentMovie: Movie) async {
        guard !isLoading, hasMorePages else { return }
        guard let lastMovie = visibleMovies.last else { return }
        guard currentMovie.id == lastMovie.id else { return }
        await loadMoviesPage(page: currentPage + 1, reset: false)
    }

    private func loadInitialData() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            async let genresTask = getGenresUseCase.execute()
            async let moviesTask = getMoviesUseCase.execute(page: 1, genreId: selectedGenreId)

            let fetchedGenres = try await genresTask
            let fetchedMovies = try await moviesTask

            genres = fetchedGenres
            currentPage = 1
            loadedMovies = getUniqueMoviesUseCase.execute(fetchedMovies)
            hasMorePages = !fetchedMovies.isEmpty
            applyFilters()
        } catch {
            errorMessage = error.localizedDescription
        }
    }


    private func resetAndReloadMovies() async {
        currentPage = 1
        hasMorePages = true
        loadedMovies = []
        visibleMovies = []
        await loadMoviesPage(page: 1, reset: true)
    }

 
    private func loadMoviesPage(page: Int, reset: Bool) async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        do {
            let fetched = try await getMoviesUseCase.execute(page: page, genreId: selectedGenreId)

            if reset {
                loadedMovies = fetched
            } else {
                loadedMovies.append(contentsOf: fetched)
            }

            loadedMovies = getUniqueMoviesUseCase.execute(loadedMovies)
            currentPage = page
            hasMorePages = !fetched.isEmpty
            applyFilters()
        } catch {
            errorMessage = error.localizedDescription
        }
    }

   
    private func applyFilters() {
        visibleMovies = searchMovieUseCase.execute(movies: loadedMovies, query: searchText)
    }

#if DEBUG
    /// SwiftUI Preview / snapshot data — no network (avoids TLS errors in Preview canvas).
    static func makePreview() -> MoviesListViewModel {
        let vm = MoviesListViewModel()
        vm.genres = [
            Genre(id: 28, name: "Action"),
            Genre(id: 12, name: "Adventure"),
            Genre(id: 16, name: "Animation")
        ]
        vm.loadedMovies = [
            Movie(id: 1, title: "Ratatouille", releaseDate: "2007-06-29", poster: nil, genreIds: [16]),
            Movie(id: 2, title: "Toy Story", releaseDate: "1995-11-22", poster: nil, genreIds: [16]),
            Movie(id: 3, title: "The Boss Baby: Family Business", releaseDate: "2021-07-02", poster: nil, genreIds: [16, 35]),
            Movie(id: 4, title: "Tangled", releaseDate: "2010-11-24", poster: nil, genreIds: [16, 10751])
        ]
        vm.hasLoadedOnce = true
        vm.applyFilters()
        return vm
    }
#endif
}
