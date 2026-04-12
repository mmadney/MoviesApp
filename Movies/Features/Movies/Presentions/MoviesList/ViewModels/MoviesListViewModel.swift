//
//  MoviesListViewModel.swift
//  Movies
//
//  Created by Madney on 12/04/2026.
//

import Foundation
import Combine

@MainActor
final class MoviesListViewModel: ObservableObject {
    // Search text from UI; each change reapplies local filtering.
    @Published var searchText: String = "" {
        didSet {
            applyFilters()
        }
    }
    // Data exposed to the view.
    @Published private(set) var genres: [Genre] = []
    @Published private(set) var selectedGenreId: Int? = nil
    @Published private(set) var visibleMovies: [Movie] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?

    private let getGenresUseCase: GetGenresUseCase
    private let getMoviesUseCase: GetMoviesUseCase

    // Full loaded list for current genre selection; search filters from this.
    private var loadedMovies: [Movie] = []
    private var currentPage: Int = 1
    private var hasLoadedOnce = false
    private var hasMorePages = true

    // Default app wiring for production usage.
    convenience init() {
        let repo = MoviesRepoImp(
            remote: MoviesRemote(),
            local: MoviesLocal(localStorage: JsonLocalStorages())
        )
        self.init(
            getGenresUseCase: GetGenresUseCase(repo: repo),
            getMoviesUseCase: GetMoviesUseCase(repo: repo)
        )
    }

    init(getGenresUseCase: GetGenresUseCase, getMoviesUseCase: GetMoviesUseCase) {
        self.getGenresUseCase = getGenresUseCase
        self.getMoviesUseCase = getMoviesUseCase
    }

    // Loads first data only once when the screen appears.
    func onAppear() async {
        guard !hasLoadedOnce else { return }
        hasLoadedOnce = true
        await loadInitialData()
    }

    // Changes selected genre then reloads movies from page 1.
    func selectGenre(_ genreId: Int?) async {
        guard selectedGenreId != genreId else { return }
        selectedGenreId = genreId
        await resetAndReloadMovies()
    }

    // Infinite scroll trigger when user reaches the last visible card.
    func loadNextPageIfNeeded(currentMovie: Movie) async {
        guard !isLoading, hasMorePages else { return }
        guard let lastMovie = visibleMovies.last else { return }
        guard currentMovie.id == lastMovie.id else { return }
        await loadMoviesPage(page: currentPage + 1, reset: false)
    }

    // Fetches genres and the first movie page in parallel for faster startup.
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
            loadedMovies = uniqueMovies(from: fetchedMovies)
            hasMorePages = !fetchedMovies.isEmpty
            applyFilters()
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    // Clears current paging state when user changes genre.
    private func resetAndReloadMovies() async {
        currentPage = 1
        hasMorePages = true
        loadedMovies = []
        visibleMovies = []
        await loadMoviesPage(page: 1, reset: true)
    }

    // Loads one page from repository and merges/de-duplicates results.
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

            loadedMovies = uniqueMovies(from: loadedMovies)
            currentPage = page
            hasMorePages = !fetched.isEmpty
            applyFilters()
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    // Applies local text search to already loaded movies.
    private func applyFilters() {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        if query.isEmpty {
            visibleMovies = loadedMovies
        } else {
            visibleMovies = loadedMovies.filter { movie in
                movie.title.lowercased().contains(query)
            }
        }
    }

    // Removes duplicates that can happen across pages/offline cache.
    private func uniqueMovies(from movies: [Movie]) -> [Movie] {
        var map: [Int: Movie] = [:]
        for movie in movies {
            map[movie.id] = movie
        }
        return map.values.sorted(by: { $0.id < $1.id })
    }
}
