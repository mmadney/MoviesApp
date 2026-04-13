//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Madney on 13/04/2026.
//

import Combine
import Factory
import Foundation

@MainActor
final class MovieDetailsViewModel: ObservableObject {
    @Published private(set) var movieDetails: MovieDetails?
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?

    @LazyInjected(\.getMovieDetailsUseCase) private var getMovieDetailsUseCase

    private let movieId: Int
    private var hasLoaded = false

    init(movieId: Int) {
        self.movieId = movieId
    }

    func onAppear() async {
        guard !hasLoaded else { return }
        hasLoaded = true
        await fetchMovieDetails()
    }

    func retry() async {
        await fetchMovieDetails()
    }

    var genresText: String {
        guard let movieDetails else { return "-" }
        return movieDetails.genres.isEmpty ? "-" : movieDetails.genres.joined(separator: ", ")
    }

    var spokenLanguagesText: String {
        guard let movieDetails else { return "-" }
        return movieDetails.spokenLanguages.isEmpty ? "-" : movieDetails.spokenLanguages.joined(separator: ", ")
    }

    var runtimeText: String {
        guard let runtime = movieDetails?.runtime else { return "-" }
        return "\(runtime) minutes"
    }

    var budgetText: String {
        return currencyText(for: movieDetails?.budget ?? 0)
    }

    var revenueText: String {
        return currencyText(for: movieDetails?.revenue ?? 0)
    }

    private func fetchMovieDetails() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        do {
            movieDetails = try await getMovieDetailsUseCase.execute(movieId: movieId)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    private func currencyText(for value: Double) -> String {
        if value <= 0 {
            return "-"
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: value)) ?? "$0"
    }
}
